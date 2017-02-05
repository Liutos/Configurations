;; SLIME
(add-hook 'slime-repl-mode-hook
	  (lambda ()
            (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
(require 'cl)
(setq common-lisp-hyperspec-root
      "~/app/HyperSpec/")
(setq slime-lisp-implementations
      '((sbcl ("/home/liutos/local/sbcl/bin/sbcl" "--core" "/home/liutos/local/sbcl/lib/sbcl/sbcl.core"))
        (ccl ("/home/liutos/local/ccl/bin/lx86cl64"))))
(setq slime-contribs '(slime-fancy))
