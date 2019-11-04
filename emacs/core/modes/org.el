;;; 不截断过长的行
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines -1)))

(setq org-hide-leading-stars t)         ; 只显示最后一颗星号
(setq org-agenda-files '("~/Dropbox/gtd/doubt.org"
                         "~/Dropbox/gtd/memo.org"
                         "~/Dropbox/gtd/progress.org"
                         "~/Dropbox/gtd/roles/developer.org"
                         "~/Dropbox/gtd/roles/employee.org"
                         "~/Dropbox/gtd/roles/gtd.org"
                         "~/Dropbox/gtd/roles/husband.org"
                         "~/Dropbox/gtd/roles/me.org"
                         "~/Dropbox/gtd/roles/player.org"
                         "~/Dropbox/gtd/roles/son.org"))
(setq org-default-notes-file "~/Dropbox/gtd/inbox.org")
(add-to-list 'holiday-other-holidays '(holiday-fixed 2 14 "情人节"))
(add-to-list 'holiday-other-holidays '(holiday-chinese 8 15 "端午节"))
(setq org-refile-targets '((nil :maxlevel . 4)
                           ("~/Dropbox/gtd/doubt.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/memo.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/progress.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/roles/employee.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/roles/developer.org" :maxlevel . 4)
                           ("~/Dropbox/gtd/roles/gtd.org" :maxlevel . 2)
                           ("~/Dropbox/gtd/roles/husband.org" :maxlevel . 2)
                           ("~/Dropbox/gtd/roles/me.org" :maxlevel . 6)
                           ("~/Dropbox/gtd/roles/son.org" :maxlevel . 1)))
(require 'org-habit)
(setq org-capture-templates
      '(("i" "Idea" entry (file+headline "~/Dropbox/gtd/inbox.org" "Anything")
         "* %?\n这个想法被记录于%T")
        ("t" "Todo" entry (file+headline "~/Dropbox/gtd/inbox.org" "Tasks")
         "* TODO %U%?\n  :PROPERTIES:\n  :CREATED_AT: %U\n  :ID: %(uuidgen-4)\n  :END:")))

;;; 自定义的org agenda命令
;;; 参考这篇文档：https://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
(setq org-agenda-custom-commands
      '(("b" "查看今天的安排（含工作）"
         ((agenda "" ((org-agenda-span 1)))
          (agenda "" ((org-agenda-files '("~/Dropbox/gtd/work.org"))
                      (org-agenda-span 1))))
         ((org-agenda-compact-blocks t)))
        ("d" "查看今天的安排" agenda ""
         ((org-agenda-span 1)))
        ("f" "查看TODO条目（按创建时间排序）" todo "TODO"
         ((org-agenda-sorting-strategy '(priority-down timestamp-up))))
        ("w" "查看今天的工作安排" agenda ""
         ((org-agenda-files '("~/Dropbox/gtd/work.org"))
          (org-agenda-span 1)))))

;; (add-to-list 'load-path "~/Documents/Projects/org-mode/contrib/lisp/")
;; (require 'org-depend)

(setq org-archive-location "~/Dropbox/gtd/Archives/%s_archive::")

(defun lt-next-todo (tag hour minute)
  "设置光标所在行为一个TODO条目，并设置其标签为TAG，SCHEDULED的提醒时间为HOUR:MINUTE

如果当前的时间已经晚于HOUR:MINUTE，那么将会设定为明天的目标小时"
  (interactive)
  (cl-assert (stringp tag))
  (cl-assert (integerp hour))
  (cl-assert (integerp minute))
  (org-todo "TODO")
  ;; 2019-10-11 23:17 - 暂时停止设置tag的功能
  ;; (org-set-tags-to tag)
  (org-set-tags nil t)
  (let ((current-hour (string-to-number (format-time-string "%H")))
        scheduled)
    (cond ((> current-hour hour)
           (setf scheduled (format "+1d %02d:%02d" hour minute)))
          (t (setf scheduled (format "%02d:%02d" hour minute))))
    (message "scheduled: %s" scheduled)
    (org-schedule nil scheduled)))
;;; 将设置TODO、设置标签，以及设置开始时间合并为一个函数
(defun lt-quick-todo (tag time)
  (interactive)
  (org-todo "TODO")
  (org-set-tags-to tag)
  (org-set-tags nil t)
  (org-schedule nil time))
(defun lt-commute-todo ()
  (lt-next-todo "@地铁" 9 0))
(defun lt-lunch-todo ()
  (lt-next-todo "@公司" 12 0))
(defun lt-rest-todo ()
  (lt-next-todo "@公司" 13 0))
(defun lt-supper-todo ()
  (lt-next-todo "@公司" 18 40))
(defun lt-night-todo ()
  (lt-next-todo "@家" 21 30))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key [C-tab] 'other-window)))
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

(setq org-global-properties
      '(("Effort_ALL" . "0:10 0:20 0:30 0:40 0:50 1:00")))
(setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM")
(setq org-todo-keywords
      '((sequence "TODO" "|" "CANCELLED(c@)" "DONE(d!)")))

(defun liutos-org-agenda-goto ()
  "调用org-agenda-goto之余，还会调用org-show-context展开上级节点"
  (interactive)
  (call-interactively 'org-agenda-goto)
  (org-show-context))
(define-key org-agenda-mode-map [tab] 'liutos-org-agenda-goto)
