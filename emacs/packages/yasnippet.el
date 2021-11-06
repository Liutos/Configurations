(use-package yasnippet-snippets
  :config
  (yas-reload-all)
  (add-hook 'ledger-mode-hook #'yas-minor-mode)
  (add-hook 'org-mode-hook #'yas-minor-mode)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'restclient-mode-hook #'yas-minor-mode)
  :ensure t)
