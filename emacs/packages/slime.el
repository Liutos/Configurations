(use-package slime-repl-ansi-color
  :ensure t)

(use-package slime
  :config
  (setq inferior-lisp-program "ros -Q run")
  (add-hook 'slime-repl-mode-hook
            (lambda ()
              (paredit-mode +1)))
  (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
  (require 'slime-autoloads)
  (slime-setup '(slime-fancy slime-repl-ansi-color))

  ;; 离线查看HyperSpec
  ;; https://stackoverflow.com/questions/23676164/viewing-the-common-lisp-hyperspec-offline-via-emacs
  (setq common-lisp-hyperspec-root "file:///Users/liutos/Documents/HyperSpec/HyperSpec/")
  :ensure t
  :if (featurep 'slime))
