(use-package helm
  :bind
  (("\C-x\C-b" . helm-buffers-list)
   ("\C-clb" . helm-bookmarks))
  :config
  (require 'helm-bookmark)
  (helm-mode -1)
  (setq org-completion-use-ido nil)
  :ensure t)
