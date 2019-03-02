;;; 通过上级目录区分同名buffer
(progn
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward))

(setq make-backup-files nil)            ; 不备份文件
(setq select-enable-clipboard t)        ; 使用剪贴板剪切和粘贴
(setq-default indent-tabs-mode nil)     ; 不使用制表符缩进
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/local/mysql/bin")
(setenv "PATH" (concat "/usr/local/bin:" "/usr/local/mysql/bin:" (getenv "PATH")))
