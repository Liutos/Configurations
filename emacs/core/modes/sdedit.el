(setq sdedit-highlights
      '(("Actor\\|Node" . font-lock-function-name-face)))

(define-derived-mode sdedit-mode fundamental-mode "sdedit"
  "编辑.sd文件的主模式"
  (setq font-lock-defaults '(sdedit-highlights)))

;;; 代码是从下面这个网页给的例子改动来的
;;; https://www.emacswiki.org/emacs/CompileCommand
(add-hook 'sdedit-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (let* ((buffer-name (buffer-name))
                          (base-name (car (split-string buffer-name "\\."))))
                     (format "sdpng %s" base-name))))))

(add-to-list 'auto-mode-alist
             '("\\.sd$" . sdedit-mode))
