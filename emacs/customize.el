;;; 加载使用第三方服务所需要的密钥
(let ((pathname "~/Data/emacs/dict.el"))
  (when (file-exists-p pathname)
    (load-file pathname)))

;;; 外观
(electric-pair-mode t)                  ; 自动插入闭括号
(menu-bar-mode 1)                       ; 隐藏菜单栏
(scroll-bar-mode -1)                    ; 隐藏垂直滚动栏
(show-paren-mode 1)                     ; 高亮匹配的括号
(tool-bar-mode -1)                      ; 隐藏工具栏
;; (set-default-font "Source Code Pro")
(when (or (eq system-type 'darwin)
          (eq system-type 'windows-nt))
  (global-hl-line-mode 1)                 ; 高亮光标所在的行
  ;; (load-theme 'gruvbox-light-soft t)
  (load-theme 'nimbus t))
(when (eq system-type 'darwin)
  (set-frame-font "Fira Code"))
;; (when (eq system-type 'gnu/linux)
;;   (set-default-font "FiraCode"))

;; (require 'chocolate-theme)

;;; 行为
;;; 通过上级目录区分同名buffer
(progn
  (setq uniquify-buffer-name-style 'forward))

(setq make-backup-files nil)            ; 不备份文件
(setq select-enable-clipboard t)        ; 使用剪贴板剪切和粘贴
(setq-default indent-tabs-mode nil)     ; 不使用制表符缩进
(when (eq system-type 'darwin)
  (add-to-list 'exec-path "/usr/local/bin")
  (add-to-list 'exec-path "/usr/local/mysql/bin")
  (add-to-list 'exec-path "/usr/local/texlive/2020/bin/x86_64-darwin")
  (setenv "PATH" (concat "/usr/local/texlive/2020/bin/x86_64-darwin:" "/usr/local/bin:" "/usr/local/mysql/bin:" (getenv "PATH"))))

;;; 定制主模式
;;; c-mode
(setq c-default-style "linux")
(setq c-basic-offset 2)

;;; faq.el
(when (featurep 'parse-faq-org)
  (let ((file (file-symlink-p "~/.emacs.d/faq_customization.el")))
    (when file
      (load file))))
;;; 定义用于helm的source
(when (featurep 'parse-faq-org)
  (setq faq-helm-sources
        (list
         `((name . "parse-faq-org的匹配结果")
           (candidates . faq-candidates)
           (action . (lambda (candidate)
                       (destructuring-bind (answer question)
                           candidate
                         (show-faq (concat question "\n" answer)))))))))

;;; js-mode
(setq js-indent-level 2)

;;; org-cuckoo
(when (featurep 'org-cuckoo)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-cuckoo-mode)))
  (setq *org-cuckoo-default-icon-file* "/Applications/Emacs.app/Contents/Resources/Emacs.icns")
  (setq *org-cuckoo-default-task-detail-extractor* 'extract-task-detail))

;;; sdedit-mode
(setq sdedit-highlights
      '(("Actor\\|Node" . font-lock-function-name-face)))
;;; 代码是从下面这个网页给的例子改动来的
;;; https://www.emacswiki.org/emacs/CompileCommand
(add-hook 'sdedit-mode-hook
          (lambda ()
            (unless (file-exists-p "Makefile")
              (set (make-local-variable 'compile-command)
                   (let* ((buffer-name (buffer-name))
                          (base-name (car (split-string buffer-name "\\."))))
                     (format "/usr/local/bin/sdedit -t png -o %s.png %s.sd" base-name base-name))))))

;;; bookmark
(add-hook 'bookmark-after-jump-hook 'goto-end-of-ledger)

;;; 配置主模式的文件后缀
(add-to-list 'auto-mode-alist
             '("\\.sd$" . sdedit-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
