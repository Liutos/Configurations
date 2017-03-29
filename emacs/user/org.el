;;; Org Mode
(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key [C-tab] 'other-window)))
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines -1)))
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-agenda-files
      '("~/src/org/target/HEAD/task.org"
        "~/src/org/target/HEAD/project.org"))
(setq org-hide-leading-stars t)
(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "DONE")))
(setq org-default-notes-file "~/src/org/target/HEAD/notes.org")
