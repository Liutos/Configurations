;;; 不截断过长的行
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines -1)))

(setq org-hide-leading-stars t)         ; 只显示最后一颗星号
(setq org-agenda-files '("~/Dropbox/gtd/coding.org"
                         "~/Dropbox/gtd/enter.org"
                         "~/Dropbox/gtd/learn.org"
                         "~/Dropbox/gtd/life.org"
                         "~/Dropbox/gtd/projects.org"
                         "~/Dropbox/gtd/Projects/cuckoo.org"
                         "~/Dropbox/gtd/reading.org"
                         "~/Dropbox/gtd/writing.org"))
(setq org-default-notes-file "~/Dropbox/gtd/inbox.org")
(add-to-list 'holiday-other-holidays '(holiday-fixed 2 14 "情人节"))
(add-to-list 'holiday-other-holidays '(holiday-chinese 8 15 "端午节"))
(setq org-refile-targets '((nil :maxlevel . 4)
                           ("~/Dropbox/gtd/coding.org" :maxlevel . 2)
                           ("~/Dropbox/gtd/enter.org" :maxlevel . 4)
                           ("~/Dropbox/gtd/learn.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/life.org" :maxlevel . 3)
                           ("~/Dropbox/gtd/projects.org" :maxlevel . 4)
                           ("~/Dropbox/gtd/Projects/cuckoo.org" :maxlevel . 1)
                           ("~/Dropbox/gtd/someday.org" :maxlevel . 2)
                           ("~/Dropbox/gtd/reading.org" :maxlevel . 4)
                           ("~/Dropbox/gtd/trash.org" :maxlevel . 4)
                           ("~/Dropbox/gtd/writing.org" :maxlevel . 1)))
(require 'org-habit)
(setq org-capture-templates
      '(("i" "Idea" entry (file+headline "~/Dropbox/gtd/whatever.org" "Anything")
         "* %?\n这个想法被记录于%T")
        ("t" "Todo" entry (file+headline "~/Dropbox/gtd/inbox.org" "Tasks")
         "* TODO %?\n")))

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
        ("w" "查看今天的工作安排" agenda ""
         ((org-agenda-files '("~/Dropbox/gtd/work.org"))
          (org-agenda-span 1)))))

(add-to-list 'load-path "~/Documents/Projects/org-mode/contrib/lisp/")
(require 'org-depend)

(setq org-archive-location "~/Dropbox/gtd/Archives/%s_archive::")

(defun lt-next-todo (tag hour minute)
  "设置光标所在行为一个TODO条目，并设置其标签为TAG，SCHEDULED的提醒时间为HOUR:MINUTE

如果当前的时间已经晚于HOUR:MINUTE，那么将会设定为明天的目标小时"
  (interactive)
  (cl-assert (stringp tag))
  (cl-assert (integerp hour))
  (cl-assert (integerp minute))
  (org-todo "TODO")
  (org-set-tags-to tag)
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
  "设置所在条目为TODO；设置标签为【@通勤】；设置开始时间为第二天的上午九点"
  (lt-next-todo "@通勤" 9 0))
(defun lt-lunch-todo ()
  (lt-next-todo "@午餐" 12 0))
(defun lt-rest-todo ()
  (lt-next-todo "@午休" 13 0))
(defun lt-supper-todo ()
  (lt-next-todo "@晚餐" 18 40))
(defun lt-night-todo ()
  (lt-next-todo "@电脑前" 21 30))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key [C-tab] 'other-window)))
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
