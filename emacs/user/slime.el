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
(setq inferior-lisp-program "sbcl")
;; (slime-setup '(slime-banner slime-fancy slime-repl-ansi-color))
(slime-setup '(slime-banner slime-fancy))

(add-to-list 'load-path "~/installer")
(require 'slime-annot)
