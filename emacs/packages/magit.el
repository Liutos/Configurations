(use-package magit
  :bind
  (("\C-cmc" . magit-checkout)
   ("\C-cmm" . magit-merge)
   ("\C-cmp" . magit-push)
   ("\C-cms" . magit-status))
  :ensure t)
