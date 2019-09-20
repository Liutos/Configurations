(use-package ledger-mode
  :config
  (add-hook 'ledger-mode #'yas-minor-mode)
  (define-key ledger-mode-map [C-tab] 'other-window))
