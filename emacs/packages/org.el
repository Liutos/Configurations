(require 'request)

(defun lt-ft-send (text desp)
  "通过方糖QQ发送微信消息给自己"
  (let ((url (format "https://sc.ftqq.com/%s.send" ftqq-seckey)))
    (request
     url
     :data (list
            (cons "text" text)
            (cons "desp" desp))
     :type "POST")))

(defun lt-post-highlight (description source)
  "向RescueTime提交Highlight数据"
  (let ((highlight-date (truncate (fround (float-time))))
        (key rescue-time-key)
        (url "https://www.rescuetime.com/anapi/highlights_post"))
    (request
     url
     :params (list
              (cons "description" description)
              (cons "highlight_date" highlight-date)
              (cons "key" key)
              (cons "source" source))
     :type "POST")))

(defun should-post-p (tag)
  "检查TAG是否需要发送到RescueTime"
  (cond ((string-prefix-p "@" tag)
         nil)
        ((or (string= tag "网页")
             (string= tag "知乎"))
         nil)
        (t t)))

(defun lt-done-highlight ()
  (let ((state org-state))
    (when (string= state "DONE")
      (let ((description (nth 4 (org-heading-components)))
            (highlightp (org-entry-get nil "HIGHLIGHTP"))
            (tags (org-get-tags-at)))
        (cond ((member "工作" tags)
               (message "当前条目含有【工作】标签，不需要推送到RescueTime上"))
              ((or (null highlightp)
                   (not (string= (downcase highlightp) "no")))
               ;; 先发出一条总的task done的数据
               (lt-post-highlight description "task done")
               ;; 再针对每一个标签（包括继承下来的标签）发出请求
               (dolist (source tags)
                 (when (should-post-p source)
                   (lt-post-highlight description source)
                   (message "发出%s标签的数据" source))))
              (t (message "当前条目的HIGHLIGHTP属性为%s，不需要推送到RescueTime上" highlightp)))))))

(add-to-list 'org-after-todo-state-change-hook 'lt-done-highlight t)

(defun lt-todo-send ()
  (interactive)
  (let ((description (nth 4 (org-heading-components)))
        (tag (nth 5 (org-heading-components))))
    (lt-ft-send (format "%s任务" tag)
                description)))

(defun lt-archive-if-manga ()
  (let ((state org-state))
    (when (string= state "DONE")
      (let ((tags (org-get-tags-at)))
        (when (or ;; (member "动画" tags)
                  (member "漫画" tags)
                  (member "充电" tags))
          (org-toggle-archive-tag))))))

(add-to-list 'org-after-todo-state-change-hook 'lt-archive-if-manga t)

;;; 在cuckoo中创建光标所在任务的定时提醒
(defun scheduled-to-time (scheduled)
  "将TODO条目的SCHEDULED属性转换为UNIX时间戳"
  ;; 为了能够支持形如<2019-06-15 Sat 14:25-14:55>这样的时间戳，会先用正则表达式提取date-to-time能够处理的部分
  (let* ((date (progn
                 (string-match "\\([0-9]+-[0-9]+-[0-9]+ [A-Za-z]+ [0-9]+:[0-9]+\\)" scheduled)
                 (match-string 0 scheduled)))
         (lst (date-to-time date)))
    (+ (* (car lst) (expt 2 16))
       (cadr lst))))

(defun create-remind-in-cuckoo (timestamp)
  "往cuckoo中创建一个定时提醒并返回这个刚创建的提醒的ID"
  (let (remind-id)
    (request
     "http://localhost:7001/remind"
     :data (json-encode-alist
            (list (cons "timestamp" timestamp)))
     :headers '(("Content-Type" . "application/json"))
     :parser 'buffer-string
     :type "POST"
     :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (message "返回内容为：%S" data)
                 (let ((remind (json-read-from-string data)))
                   (setq remind-id (cdr (assoc 'id (cdr (car remind))))))))
     :sync t)
    remind-id))

(defun extract-task-detail ()
  (let ((tags (org-get-tags-at)))
    (cond ((member "动画" tags)
           (save-excursion
             (outline-up-heading 1)
             (nth 4 (org-heading-components))))
          (t ""))))

(defun create-task-in-cuckoo ()
  (interactive)
  (let ((brief)
        (detail)
        (remind-id)
        (task-id))

    (setq brief (nth 4 (org-heading-components)))
    (setf detail (extract-task-detail))

    (let* ((scheduled (org-entry-get nil "SCHEDULED"))
           (timestamp (scheduled-to-time scheduled)))
      (setq remind-id (create-remind-in-cuckoo timestamp)))
    
    (request
     "http://localhost:7001/task"
     :data (concat "brief=" (url-encode-url brief) "&detail=" (url-encode-url detail) "&remind_id=" (format "%S" remind-id))
     :parser 'buffer-string
     :type "POST"
     :success (cl-function
               (lambda (&key data &allow-other-keys)
                 (message "data: %S" data)
                 (let ((task (json-read-from-string data)))
                   (setq task-id (cdr (assoc 'id (cdr (car task)))))
                   (message "任务%S创建完毕" task-id))))
     :sync t)
    (org-set-property "ID" (number-to-string task-id))))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\C-cr" 'create-task-in-cuckoo)))
