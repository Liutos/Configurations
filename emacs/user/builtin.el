(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq make-backup-files nil)
(setq select-enable-clipboard t)
;;; 使用空格代替制表符
(setq-default indent-tabs-mode nil)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH' 2> /dev/null")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

(load-file "~/.emacs.d/user/cc.el")
(load-file "~/.emacs.d/user/ido.el")
(load-file "~/.emacs.d/user/iswitchb.el")
(load-file "~/.emacs.d/user/js-mode.el")
(load-file "~/.emacs.d/user/org.el")

(run-at-time "11:00pm" nil (lambda ()
                             (shell-command "notify-send -i terminal '整理今天的照片'")))
