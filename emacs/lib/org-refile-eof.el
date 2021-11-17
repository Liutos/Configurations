;;; 将当前条目剪切并粘贴到某个目标.org文件的末尾
;;; 定义一个Helm的source，以便选择要粘贴的.org文件
(defvar *org-refile-eof--helm-source* nil
  "用于提供目标.org文件下拉菜单的来源")

(setq *org-refile-eof--helm-source*
      '((name . "refile到下列的哪个文件")
        (candidates . org-agenda-files)
        (action . (lambda (candidate)
                    candidate))))

(defun org-refile-to-eof ()
  "将当前条目剪切到一个.org文件的末尾。"
  (interactive)
  ;; 先调用Helm获取目标.org文件。这里需要处理没有选中任何文件的情况
  (let ((path (helm :sources '(*org-refile-eof--helm-source*))))
    (when path
      (let ((previous-buffer (current-buffer)))
        ;; TODO: 调用org-cut-subtree剪走当前条目
        ;; (message "剪切当前条目")
        (org-cut-subtree)
        ;; 打开选中的文件的buffer，并移动到最后
        (find-file path)
        (end-of-buffer)
        ;; 调用org-paste-subtree粘贴进去
        ;; (message "调用org-paste-subtree粘贴内容")
        (org-paste-subtree)
        (switch-to-buffer previous-buffer)))))

(provide 'org-refile-eof)

;;; org-refile-eof ends here
