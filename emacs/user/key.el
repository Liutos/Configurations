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
(global-set-key [f5] 'revert-buffer)

(global-set-key "\C-cf" 'lt-cd-shefenqi)
