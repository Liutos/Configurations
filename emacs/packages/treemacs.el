(use-package treemacs
  :config
  (require 'treemacs-evil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  ;; deferred 变体与 extended 相同，依赖 python3，异步高亮文件与目录的 git 状态
  (treemacs-git-mode 'deferred)
  :bind ("C-c t" . treemacs)
  :ensure t)

;; 只负责从 MELPA 装包；实际的加载在上面 treemacs 的 :config 里
(use-package treemacs-evil
  :ensure t)
