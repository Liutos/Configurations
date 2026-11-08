(use-package helm-projectile
  ;; 用 helm 界面在整个工程里按名找文件；不启用 helm-projectile-on，
  ;; 以免把 projectile 的补全系统整体切成 helm
  :bind ("C-c f" . helm-projectile-find-file)
  :ensure t)
