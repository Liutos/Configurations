(use-package treemacs
  :config
  (require 'treemacs-evil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind ("C-c t" . treemacs)
  :ensure t)

;; 只负责从 MELPA 装包；实际的加载在上面 treemacs 的 :config 里
(use-package treemacs-evil
  :ensure t)
