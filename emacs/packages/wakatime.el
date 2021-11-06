(let ((pathname "~/Data/emacs/wakatime.el"))
  (use-package wakatime-mode
    :config
    (load-file pathname)
    (add-hook 'prog-mode-hook 'wakatime-mode)
    :ensure t
    :if (file-exists-p pathname)))
