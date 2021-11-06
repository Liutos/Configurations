(use-package idle-highlight-mode
  :config
  (add-hook 'prog-mode-hook
            (lambda () (idle-highlight-mode t)))
  :ensure t)
