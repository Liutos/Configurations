(use-package restclient
  :config
  (add-hook 'restclient-mode-hook
            'disable-indentation)
  :ensure t
  :mode ("restclient$" . restclient-mode))
