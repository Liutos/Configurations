(use-package flycheck
  :config
  (add-hook 'js-mode-hook #'flycheck-mode)
  :ensure t)
