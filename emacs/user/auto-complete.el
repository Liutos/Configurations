(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq-default ac-sources
	      '(ac-source-words-in-same-mode-buffers))
;;; 在键入3个字符之后弹出补全菜单
(setq ac-auto-start 3)
;;; 在0.7秒之后再显示补全菜单
(setq ac-auto-show-menu 0.7)
;;; 设定颜色
(set-face-background 'ac-candidate-face "gray")
(set-face-underline-p 'ac-candidate-face "black")
(set-face-background 'ac-selection-face "blue")
