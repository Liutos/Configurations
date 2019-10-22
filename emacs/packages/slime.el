(load (expand-file-name "~/.roswell/helper.el"))
(setq inferior-lisp-program "ros -Q run")
(add-hook 'slime-repl-mode-hook
	  (lambda ()
            (paredit-mode +1)))
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;;; SLIME不能正确显示ANSI颜色序列的解决办法参见这里
;;; https://github.com/deadtrickster/slime-repl-ansi-color
(load-file "~/Documents/Scripts/slime-repl-ansi-color.el")
(slime-setup '(slime-fancy slime-repl-ansi-color))

;;; 离线查看HyperSpec
;;; https://stackoverflow.com/questions/23676164/viewing-the-common-lisp-hyperspec-offline-via-emacs
(setq common-lisp-hyperspec-root "file:///Users/liutos/Documents/HyperSpec/HyperSpec/")
