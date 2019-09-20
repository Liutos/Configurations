;;; 配置来自这里：https://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
(require 'xref-js2)
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook
          (lambda ()
            (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
