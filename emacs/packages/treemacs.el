(use-package treemacs
  :config
  (require 'treemacs-evil)
  (setq treemacs-width 46)
  ;; 不用 side window，否则从侧边栏发起 org-agenda 这类全帧命令会报
  ;; "Cannot make side window the only window"；C-x 1 的保护靠 no-delete-other-windows 参数，不受影响
  (setq treemacs-display-in-side-window nil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  ;; deferred 变体与 extended 相同，依赖 python3，异步高亮文件与目录的 git 状态
  (treemacs-git-mode 'deferred)
  :bind ("C-c t" . treemacs)
  :ensure t)

;; 只负责从 MELPA 装包；实际的加载在上面 treemacs 的 :config 里
(use-package treemacs-evil
  :ensure t)
