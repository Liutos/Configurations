(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;; 下列配置来自这里：https://simpletutorials.com/c/3039/How+to+resolve+%26quot%3BUndeclared+variable+or+function+%26%23x27%3Bmodule%26%23x27%3B%26quot%3B+error+thrown+by+js2-mode+in+Spacemacs
(setq js2-include-node-externs t)

(add-hook 'js2-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-f" 'lt-cd-shefenqi)))

;;; 下列配置来自这里：https://stackoverflow.com/questions/35162106/how-to-disable-js2-mode-syntax-checking-globally-in-spacemacs
(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)
