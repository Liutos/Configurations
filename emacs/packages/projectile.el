(use-package projectile
  ;; projectile 不再默认占用 C-c p，需要显式绑定命令前缀
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  ;; package-install ag
  ;; brew install the_silver_searcher
  (projectile-mode)
  :ensure t)
