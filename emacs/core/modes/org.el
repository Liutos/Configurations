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
                           ("~/Dropbox/gtd/life.org" :maxlevel . 2)
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

;;; 将设置TODO、设置标签，以及设置开始时间合并为一个函数
(defun lt-quick-todo (tag time)
  (interactive)
  (org-todo "TODO")
  (org-set-tags-to tag)
  (org-set-tags nil t)
  (org-schedule nil time))
(defun lt-commute-todo ()
  "设置所在条目为TODO；设置标签为【@通勤】；设置开始时间为第二天的上午九点"
  (interactive)
  (org-todo "TODO")
  (org-set-tags-to "@通勤")
  (org-set-tags nil t)
  (org-schedule nil "+1d 09:00"))
(defun lt-lunch-todo ()
  "设置午餐任务"
  (interactive)
  (org-todo "TODO")
  (org-set-tags-to "@午餐")
  (org-set-tags nil t)
  (org-schedule nil "+1d 12:00"))
(defun lt-rest-todo ()
  (lt-quick-todo "@午休" "+1d 13:00"))
(defun lt-supper-todo ()
  (lt-quick-todo "@晚餐" "+1d 18:40"))
(defun lt-night-todo ()
  (lt-quick-todo "@电脑前" "+1d 21:30"))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key [C-tab] 'other-window)))
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
