;;; 放置无副作用的定义
(defun lt-next-todo (hour minute &optional duration)
  "设置光标所在行为一个TODO条目，并设置其SCHEDULED为HOUR:MINUTE。

如果当前的时间已经晚于HOUR:MINUTE，那么将会设定为明天的目标小时。
如果DURATION不为空，会作为持续的小时和分钟数追加到最终的SCHEDULED属性值中。"
  (cl-assert (integerp hour))
  (cl-assert (integerp minute))
  (org-todo "TODO")
  ;; (org-set-tags nil t)
  (let ((current-hour (string-to-number (format-time-string "%H")))
        scheduled)
    (cond ((> current-hour hour)
           (setf scheduled (format "+1d %02d:%02d" hour minute)))
          (t (setf scheduled (format "%02d:%02d" hour minute))))
    (when duration
      (setf scheduled (format "%s+%s" scheduled duration)))
    (message "scheduled: %s" scheduled)
    (if (featurep 'org-cuckoo)
        (org-cuckoo-schedule nil scheduled)
      (org-schedule nil scheduled))))

;;; 将设置TODO、设置标签，以及设置开始时间合并为一个函数
(defun lt-quick-todo (tag time)
  (interactive)
  (org-todo "TODO")
  (org-set-tags-to tag)
  (org-set-tags nil t)
  (org-schedule nil time))
(defun lt-commute-todo ()
  (lt-next-todo 9 0))
(defun lt-lunch-todo ()
  (lt-next-todo 12 0))
(defun lt-rest-todo ()
  (lt-next-todo 13 0))
(defun lt-supper-todo ()
  (lt-next-todo 18 40))
(defun lt-night-todo ()
  (lt-next-todo 21 30))

(defun liutos-org-agenda-goto ()
  "调用org-agenda-goto之余，还会调用org-show-context展开上级节点"
  (interactive)
  (call-interactively 'org-agenda-goto)
  (org-show-context))

(defvar *schedule-shortcuts* nil
  "用于设定TODI条目的SCHEDULED属性的快捷方式")

(defvar *helm-quick-schedule-source*
  `((name . "设置TODO的SCHEDULED属性")
    (candidates . *schedule-shortcuts*)
    (action . (lambda (candidate)
                (helm-marked-candidates)))))

(defun lt--shortcuts-to-sources (shortcuts)
  "将*schedule-shortcuts*转换为可用于Helm的来源。"
  (flet ((aux (shortcut)
              (cl-destructuring-bind (desc . times)
                  shortcut
                (cons (if (caddr times)
                          (format "%s (%02d:%02d+%s)" desc (car times) (cadr times) (caddr times))
                        (format "%s (%02d:%02d)" desc (car times) (cadr times)))
                      times))))
    (mapcar (lambda (spec)
              (cl-destructuring-bind (name . shortcuts)
                  spec
                `((name . ,name)
                  (candidates . ,(mapcar #'aux shortcuts))
                  (action . (lambda (candidate)
                              (helm-marked-candidates))))))
            shortcuts)))

(defun helm-quick-schedule ()
  "从下拉列表选择完后SCHEDULED模式后修改当前TODO条目的SCHEDULED属性。"
  (interactive)
  (let* ((sources (lt--shortcuts-to-sources *schedule-shortcuts*))
         (spec (car (helm :sources sources))))
    (when spec
      (apply 'lt-next-todo spec))))

;;; 在一个条目完成后将耗时记录到文件中
(defun compute-time-cost ()
  "计算当前所处的条目从创建时起至今过了多久"
  (- (truncate (float-time))
     (scheduled-to-time (org-entry-get nil "CREATED_AT"))))

(defun record-time-cost ()
  "将当前条目从创建到完成的耗时记录在文件中"
  (interactive)
  (cl-block record-time-cost
    (let ((state org-state))
      (unless (string= state "DONE")
        (cl-return-from record-time-cost))

      (let* ((created-at (org-entry-get nil "CREATED_AT"))
             (current-time (truncate (float-time)))
             (text (nth 4 (org-heading-components))))
        (unless created-at
          (cl-return-from record-time-cost))

        (setq created-at (scheduled-to-time created-at))
        (message "%s,%d,%d" text created-at current-time)
        (write-region (format "%s,%d,%d\n" text created-at current-time)
                      nil
                      "/Users/liutos/Data/emacs/task-time-cost.csv"
                      'append)))))

(defun lt-org-move-episode-to-drawer ()
  "往上级heading的drawer中插入一个内容，并删除当前heading。"
  ;; 用cl-block来实现nonlocal-exit
  (cl-block lt-org-move-episode-to-drawer
    (let ((state org-state))
      (unless (string= state "DONE")
        (cl-return-from lt-org-move-episode-to-drawer)))

    (let ((tags (org-get-tags-at))
          (text (nth 4 (org-heading-components))))
      ;; 只处理内容以“观看”开头、带有“动画”标签的heading
      (unless (and (or (string-prefix-p "观看" text)
                       (string-prefix-p "继续阅读" text))
                   (or (member "动画" tags)
                       (member "阅读" tags)))
        (cl-return-from lt-org-move-episode-to-drawer))

      (save-excursion
        (let (current-position)
          ;; 记下当前的位置，之后搜索的时候到这里为止
          (setq current-position (point))
          ;; 往上走一级，以便寻找一个名字叫做“观看进度”的drawer
          (widen)
          (outline-up-heading 1)
          (unless (search-forward ":观看进度:" current-position t)
            (message "请自行创建“观看进度”的drawer")
            (cl-return-from lt-org-move-episode-to-drawer))

          ;; 继续往前找到:END:的标记
          (unless (search-forward ":END:" current-position t)
            (message "请确保有完整的“观看进度”的drawer")
            (cl-return-from lt-org-move-episode-to-drawer))
          ;; 往左走五步
          (backward-char 5)
          ;; 开辟一行新的，然后把刚刚完成的任务的内容和时间戳放进来
          (org-open-line 1)
          (insert (format "“%s” DONE at %s" text (current-time-string)))))
      (org-cut-subtree))))
;;; 快速设置相邻两个条目的状态和TRIGGER属性
(defun lt-org-set-todo-and-trigger ()
  "将当前条目设置为TODO，设置TRIGGER属性，并取消下一条的状态。"
  (interactive)
  (org-todo "TODO")
  (org-set-property "TRIGGER" "next-sibling chain!(\"TRIGGER\") todo!(TODO)")
  (let ((has-next-sibling (save-excursion
                            (outline-get-next-sibling))))
    (when has-next-sibling
      (org-forward-heading-same-level 1)
      (org-todo 'none))))

;;; 开始定义lt-org-delay-inactive-timestamp
(defun lt-org--has-next-p ()
  "返回T或NIL表示是否有下一个兄弟节点。"
  (save-excursion
    (org-get-next-sibling)))

(defun lt-org--get-headline-text ()
  "返回当前节点的heading。"
  (nth 4 (org-heading-components)))

(defun lt-org--starts-with-timestamp-p (text)
  "返回T或NIL表示输入字符串是否以一个inactive timestamp开头。"
  ;; Emacs的正则表达式并不支持如\d和\w这样的类，所以要写成[0-9]和[A-Za-z]的形式
  (string-match "^\\[[0-9]+-[0-9]+-[0-9]+ [A-Za-z]+ [0-9]+:[0-9]+\\]" text))

(defun lt-org--delay-timestamp (text new-timestamp)
  "用NEW-TIMESTAMP替换TEXT中的inactive timestamp。

如果TEXT没有以inactive timestamp开头，则直接添加NEW-TIMESTAMP。"
  (format "%s%s" new-timestamp
          (if (lt-org--starts-with-timestamp-p text)
              (substring text 22)
              text)))

(defun lt-org-delay-inactive-timestamp ()
  "推迟当前条目的inactive timestamp和CREATED_AT。"
  (interactive)
  (while (lt-org--has-next-p)
    (org-move-subtree-down))
  (message "将当前条目移到了最下方")

  (let ((headline-text (lt-org--get-headline-text))
        (new-timestamp (format-time-string "[%Y-%m-%d %a %H:%M]")))
    (org-set-property "CREATED_AT" new-timestamp)
    (message "更新了CREATED_AT属性")

    (org-edit-headline (lt-org--delay-timestamp headline-text new-timestamp))
    (message "更新了headline text中的时间戳")))

(define-derived-mode sdedit-mode fundamental-mode "sdedit"
  "编辑.sd文件的主模式"
  (setq font-lock-defaults '(sdedit-highlights)))

(defun lt-cd-shefenqi ()
  "Find things under ~/Shefenqi/Projects/ directory."
  (interactive)
  (let ((default-directory "~/Shefenqi/Projects/"))
    (call-interactively 'ido-find-file)))

(defun copy-buffer-path ()
  "将当前buffer的文件的绝对路径复制到剪贴板中。

如果当前buffer的主模式为dired-mode，会复制光标所在文件的绝对路径。
如果当前buffer的主模式为org-mode，还将尝试复制所在entry的绝对链接。"
  (interactive)
  (let ((apath (buffer-file-name)))
    (when apath
      (kill-new apath)
      (message "已将文件绝对路径复制到剪贴板"))
    ;; 复制带有行号的内容
    (let ((linum (line-number-at-pos)))
      (kill-new (format "file:%s::%d" apath linum))
      (message "已将带有行号的文件绝对路径复制到剪贴板")))
  (cond ((eq major-mode 'dired-mode)
         (let ((path (dired-filename-at-point)))
           (message "已将光标所在文件的绝对路径复制到剪贴板")
           (kill-new path)))
        ((eq major-mode 'org-mode)
         (let ((custom-id (org-entry-get nil "CUSTOM_ID"))
               (id (org-entry-get nil "ID")))
           (when (and (not custom-id)
                      id)
             (org-set-property "CUSTOM_ID" id)
             (setf custom-id id))
           (when custom-id
             (let ((link (format "file:%s::#%s" (buffer-file-name) custom-id)))
               (kill-new link)
               (message "已将带有光标所在条目的CUSTOM_ID的文件路径复制到剪贴板")))))))

(defun up-to-top ()
  "将当前条目一直移动到最上面"
  (interactive)
  (loop
   (org-move-subtree-up)))

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

(defun extract-task-detail ()
  (let ((tags (org-get-tags-at)))
    (cond ((or (member "动画" tags)
               (member "阅读" tags))
           (save-excursion
             (org-show-context)
             (outline-up-heading 1)
             (format "《%s》" (nth 4 (org-heading-components)))))
          (t ""))))

(defun disable-indentation ()
  "取消REST Client模式中的缩进"
  (electric-indent-local-mode 1))

(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))

(defconst my-protobuf-style
  '((c-basic-offset . 2)))

(cl-defun delete-headline-inactive-timestamp ()
  "当条目状态变为CANCELLED或DONE时，删除条目标题头部的inactive timestamp。"
  (interactive)
  (unless (member org-state '("CANCELLED" "DONE"))
    (cl-return-from delete-headline-inactive-timestamp))
  (let ((headline (lt-org--get-headline-text)))
    (when (lt-org--starts-with-timestamp-p headline)
      (save-match-data
        (org-edit-headline (substring headline 22))))))

(defun goto-end-of-ledger ()
  "当通过书签跳入账本时跳转到文件末尾。"
  (when (string= (buffer-file-name)
                 "/Users/liutos/Dropbox/Accounting/2022.ledger")
    (end-of-buffer)))

;;; 模拟按键，以便在没有Touchbar的键盘上快捷输入C-c、C-x，以及C-cl
(defun simulate-C-c ()
  "模拟输入C-c"
  (interactive)
  (setq unread-command-events (listify-key-sequence "\C-c")))
(defun simulate-C-x ()
  "模拟输入C-x"
  (interactive)
  (setq unread-command-events (listify-key-sequence "\C-x")))
(defun simulate-C-c-l ()
  "模拟输入C-c l"
  (interactive)
  (setq unread-command-events (listify-key-sequence "\C-cl")))

(defun lt--insert-at-start-end ()
  "为TEXT中的每一行添加PREFIX前缀和SUFFIX后缀。"
  (interactive)
  (let* ((text (buffer-substring-no-properties (mark) (point)))
         (prefix (read-from-minibuffer "插入的前缀："))
         (suffix (read-from-minibuffer "插入的后缀："))
         (lines (split-string text "[\n\r]+"))
         (decorated-lines
          (mapcar (lambda (line)
                    (concat prefix line suffix))
                  lines))
         (new-text (mapconcat 'identity decorated-lines "\n")))
    (delete-region (mark) (point))
    (insert new-text)))

;; 自定义的org-agenda排序函数
(cl-defun lt--cmp (a b)
  ;; 参考这里的方法改一下：https://emacs.stackexchange.com/questions/26351/custom-sorting-for-agenda
  (flet ((aux (pos)
              (let ((headline (org-entry-get pos "ITEM"))
                    (priority (org-entry-get pos "PRIORITY"))
                    (score)
                    (tags (org-entry-get pos "TAGS")))
                ;; 把有【目标】标签的一方排在前面
                ;; 把有【bug】标签的一方排在前面
                ;; 把优先级高的一方排在前面
                ;; 把有【重要】标签的一方排在前面
                (setf score
                      (cond ((search "目标" tags) 4)
                            ((search "bug" tags) 3)
                            ((string= priority "A") 2)
                            ((search "重要" tags) 1)
                            (t 0)))
                (message "条目“%S”的分数为%S" headline score)
                score)))
    (let ((a-pos (get-text-property 0 'org-marker a))
          (b-pos (get-text-property 0 'org-marker b)))
      (let ((a-score (aux a-pos))
            (b-score (aux b-pos)))
        (- a-score b-score)))))

;;; 定义一系列计算不同类型的开支的ELisp函数。
(defun calculate-balance (begin-date end-date query)
  "调用ledger计算出一个特定的开支。"
  (message "begin-date为%s" begin-date)
  (let* ((command (make-ledger-command begin-date end-date query))
         (output (invoke-command command))
         ;; 提取出数值的部分
         (literal (string-match "\\([0-9.]+\\)" output)))
    (if literal
        (match-string 0 output)
      "0.00")))

(defun invoke-command (command)
  "运行一道命令COMMAND。"
  (message "待运行的命令为%s" command)
  (string-trim (shell-command-to-string command)))

(defun make-ledger-command (begin-date end-date query)
  "生成一道调用ledger的命令。"
  (format "ledger -b %s -e %s -f ~/Dropbox/Accounting/2021.ledger balance %s | tail -1" begin-date end-date query))

;;; 一个负责生成uuid，一个负责重用并清空。
(lexical-let (lt-org-capture--uuid)
  (defun lt-org-capture-uuidgen ()
    "生成一个UUID并填充到词法作用域的变量中。"
    (setf lt-org-capture--uuid (uuidgen-4))
    lt-org-capture--uuid)
  (defun lt-org-capture-uuidclr ()
    "返回生成好的UUID并清空它。"
    lt-org-capture--uuid))

(cl-defun lt-plantuml-write ()
  "编译当前buffer，生成同名的PNG文件。"
  (interactive)
  (let ((input-file (buffer-file-name)))
    (unless input-file
      (message "当前buffer不属于任何文件，请先保存。")
      (cl-return-from lt-plantuml-write))

    (let ((cmd (format "java -jar %s -charset UTF-8 %s" plantuml-jar-path input-file)))
      (message "即将运行的命令为：%s" cmd)
      (shell-command cmd)
      (message "PNG文件生成完毕。"))))

(cl-defun lt-around-org-insert-item (oldfunction &rest args)
  "在调用了org-insert-item后识时务地追加 [ ]这样的内容。"
  (let ((is-checkbox nil)
        (line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    ;; 检查当前行是否为checkbox
    (when (string-match-p "- \\[.\\]" line)
      (setf is-checkbox t))
    ;; 继续使用原来的org-insert-item插入文本
    (apply oldfunction args)
    ;; 决定要不要追加“ [ ]”字符串
    (when is-checkbox
      (insert "[ ] "))))

(cl-defun lt-org-schedule-now ()
  "为光标所在条目设置SCHEDULED属性为当前时间，并持续25分钟。"
  (interactive)
  (let ((hour (string-to-number (format-time-string "%H")))
        (minute (string-to-number (format-time-string "%M"))))
    (lt-next-todo hour minute "0:25")
    (org-clock-in)))

;;; 自定义的在成对的括号、引号间跳转的功能
(cl-defun lt-backward-sexp ()
  "从右括号或引号，跳转到对应的左括号或引号。"
  (interactive)
  (let ((c (string-to-char (string (char-after)))))
    (if (char-equal c ?\))
        (progn
          (forward-char)
          (backward-list))
      (backward-sexp))))

(cl-defun lt-forward-sexp ()
  "从左括号或引号，跳转到对应的右括号或引号。"
  (interactive)
  (forward-sexp))

(defun ledger-dup-account ()
  "重复当前行的账户。"
  (interactive)
  (let ((line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    (let ((is-contain-hyphen
           (string-match-p (regexp-quote "-") line)))
      (when is-contain-hyphen
        (setf line
              (first (split-string line "-"))))
      ;; 往下开辟一行
      (evil-open-below 1)
      ;; 移动到行首并删除剩余内容，以便粘贴
      (move-beginning-of-line nil)
      (kill-line)
      (insert line))))

(cl-defun lt-mark-next-sibling-todo ()
  "将下一个条目标记为TODO。"
  ;; org-mode条目的API：https://orgmode.org/manual/Using-the-Property-API.html
  (interactive)
  (let ((state org-state))
    (when (not (member state '("CANCELLED" "DONE")))
      (return-from lt-mark-next-sibling-todo)))

  (let ((trigger (cdr (assoc "TRIGGER" (org-entry-properties nil "TRIGGER") #'string-equal))))
    (unless trigger
      (return-from lt-mark-next-sibling-todo))

    (let ((has-next-sibling (save-excursion
                              (outline-get-next-sibling))))
      (unless has-next-sibling
        (return-from lt-mark-next-sibling-todo))
      (let ((set-todo (string-match "next-sibling.+todo!(TODO)" trigger))
            (copy-deadline (string-match "next-sibling.+deadline!(copy)" trigger))
            (copy-trigger (string-match "next-sibling.+chain!(\"TRIGGER\")" trigger))
            (deadline (cdr (assoc "DEADLINE" (org-entry-properties nil "DEADLINE") #'string-equal))))
        (when (and (not set-todo) (not copy-deadline))
          (return-from lt-mark-next-sibling-todo))
        (save-excursion
          (org-forward-heading-same-level 1 t)
          (when set-todo
            (org-todo "TODO"))
          (when copy-deadline
            (org-deadline nil deadline))
          (when copy-trigger
            (org-set-property "TRIGGER" trigger)))))))
