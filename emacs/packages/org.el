(use-package ob-restclient
  :ensure t)

(use-package org
  :bind
  (("\C-ca" . org-agenda)
   ("\C-cc" . org-capture))
  :config
  (require 'org-agenda)
  (setq org-hide-leading-stars t)         ; 只显示最后一颗星号

  (add-to-list 'holiday-other-holidays '(holiday-fixed 2 14 "情人节"))
  (add-to-list 'holiday-other-holidays '(holiday-chinese 8 15 "端午节"))
  (setq org-refile-targets '((nil :maxlevel . 4)
                             (org-agenda-files :maxlevel . 6)))

  (setq org-global-properties
        '(("DEVICE_ALL" . "mobilePhone")
          ("Effort_ALL" . "0:10 0:20 0:30 0:40 0:50 1:00")))
  (setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM")
  (setq org-todo-keywords
        '((sequence "TODO" "|" "CANCELLED(c@)" "DONE(d!)")
          (type "TODO" "WAITING")))

  (setq org-descriptive-links nil)

  ;; 不截断过长的行
  (add-hook 'org-mode-hook
            (lambda ()
              (toggle-truncate-lines -1)))
  (add-hook 'org-after-todo-state-change-hook 'delete-headline-inactive-timestamp t)
  (when (eq system-type 'darwin)
    (add-hook 'org-after-todo-state-change-hook 'record-time-cost t))
  (add-hook 'org-after-todo-state-change-hook 'lt-org-move-episode-to-drawer t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t)))

  (advice-add 'org-insert-item :around #'lt-around-org-insert-item)
  (add-hook 'org-after-todo-state-change-hook 'lt-mark-next-sibling-todo)
  ;; 加载平台相关的配置文件
  (setq org-agenda-custom-commands
        '(("d" "查看今天的安排"
           ((agenda "" ((org-agenda-span 1)))
            (tags-todo "PRIORITY=\"A\"")))))
  (let ((pathname "/Users/liutos/Dropbox/SourceCode/elisp/org_customization.el"))
    (when (file-exists-p pathname)
      (load-file pathname)))
  ;; keys.el
  (define-key org-agenda-mode-map [tab] 'liutos-org-agenda-goto)
  (define-key org-mode-map "\C-cls" 'helm-quick-schedule)
  (define-key org-mode-map "\C-clt" 'lt-org-set-todo-and-trigger)
  (define-key org-mode-map "\C-cld" 'lt-org-delay-inactive-timestamp)
  (define-key org-mode-map "\C-cou" 'up-to-top)
  (define-key org-mode-map [C-tab] 'other-window)
  (define-key org-mode-map "\C-cln" 'lt-org-schedule-now))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  :ensure t)
