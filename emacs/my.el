;;; 启动期放宽 GC 阈值
;; esup 实测启动中有 118 次 GC、累计占用 6 秒，绝大部分是启动期频繁回收造成的，
;; 这里先拉到极高值，等启动完再回落到 16MB
(defvar my--startup-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (max my--startup-gc-cons-threshold (* 16 1024 1024)))))

;;; 配置目录：按平台取不同路径
;; 四个文件拆成各自独立的顶层表达式，这样 esup 才能逐文件计时
(defvar my--config-dir
  (pcase system-type
    ('darwin     "~/Projects/Configurations/emacs/")
    ('gnu/linux  "~/Projects/Configurations/emacs/")
    ('windows-nt "E:\\Projects\\configurations\\emacs\\")))

(load (expand-file-name "include.el" my--config-dir))
(load (expand-file-name "defs.el" my--config-dir))
(load (expand-file-name "customize.el" my--config-dir))
(load (expand-file-name "keys.el" my--config-dir))
