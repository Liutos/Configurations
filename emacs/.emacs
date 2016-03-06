(electric-pair-mode t)
(global-hl-line-mode 1)
(global-set-key "\C-cn" 'forward-list)
;;; 绑定M-0为跳转到与当前左括号匹配的右括号
(global-set-key "\M-0" 'forward-list)
(global-set-key "\C-cp" 'backward-list)
;;; 绑定M-9为跳转到与当前右括号匹配的左括号
(global-set-key "\M-9" 'backward-list)
(global-set-key [C-tab] 'other-window)
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key "\M- " 'set-mark-command)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq make-backup-files nil)
(setq x-select-enable-clipboard t)
;;; 使用空格代替制表符
(setq-default indent-tabs-mode nil)

(show-paren-mode 1)

(tool-bar-mode -1)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system
    (set-exec-path-from-shell-PATH))

;; Auto-Complete
(add-to-list 'load-path "~/.emacs.d/elpa/popup-20150626.711")
(require 'popup)
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20150618.1949")
(require 'auto-complete-config)
(ac-config-default)

;; CC
(c-set-offset 'case-label '+)
(setq c-basic-offset 4)

;; Enhanced Ruby Mode
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(setq enh-ruby-program "/home/liutos/.rvm/rubies/ruby-2.2.3/bin/ruby")

;;; Html Mode
(add-hook 'html-mode-hook
          (lambda ()
            (set (make-local-variable 'sgml-basic-offset) 4)))

;;; IDO Mode
(require 'ido)
(ido-mode 'buffers)
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
                           "*Messages*" "Async Shell Command"))

;;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(setq-default magit-git-executable "/home/liutos/local/git/bin/git")

;; MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

;;; Neo Tree
(add-to-list 'load-path "~/.emacs.d/elpa/neotree-20150911.2204")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; OCaml / Tuareg Mode
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

;;; Org Mode
(add-hook 'org-mode-hook
	  (lambda ()
	    (local-set-key [C-tab] 'other-window)))
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files
      '("~/src/org/target/2015.org"))
(setq org-hide-leading-stars t)
(setq org-todo-keywords
      '((sequence "TODO" "DOING" "DONE")))

;; ParEdit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)

;; Powerline
(add-to-list 'load-path "~/.emacs.d/elpa/powerline-20150922.1143")
(require 'powerline)
(powerline-default-theme)

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
(setq slime-lisp-implementations
      '((sbcl ("/home/liutos/local/sbcl/bin/sbcl" "--core" "/home/liutos/local/sbcl/lib/sbcl/sbcl.core"))))
(setq slime-contribs '(slime-fancy))

;;; smex
(add-to-list 'load-path "~/.emacs.d/elpa/smex-20150822.1146")
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; Switch Window
(global-set-key (kbd "C-x o") 'switch-window)
