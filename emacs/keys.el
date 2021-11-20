;;; 全局按键
(global-set-key "\M-0" 'lt-forward-sexp)
(global-set-key "\M-9" 'lt-backward-sexp)
(global-set-key [C-tab] 'other-window)
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key "\M- " 'set-mark-command)
(global-set-key [f6] 'other-window)
(global-set-key [f5] 'revert-buffer)
(global-set-key "\C-c\C-f" 'lt-cd-shefenqi)
(global-set-key "\C-clp" 'copy-buffer-path)
(when (featurep 'parse-faq-org)
  (global-set-key "\C-cla" 'lt-ask))
(global-set-key (kbd "s-]") 'other-window)
(global-set-key "\C-clf" 'lt-cd-shefenqi)
(global-set-key [f10] 'simulate-C-c)
(global-set-key [f11] 'simulate-C-x)
(global-set-key [f12] 'simulate-C-c-l)
(global-set-key "\C-cli" 'lt--insert-at-start-end)

;;; 模式按键
(when (featurep 'org-cuckoo)
  (define-key org-mode-map "\C-clr" 'create-task-in-cuckoo)
  (define-key org-mode-map "\C-c\C-s" 'org-cuckoo-schedule)
  (define-key org-mode-map "\C-clv" 'org-cuckoo-view-task))

(when (featurep 'org-refile-eof)
  (define-key org-mode-map "\C-clw" 'org-refile-to-eof))