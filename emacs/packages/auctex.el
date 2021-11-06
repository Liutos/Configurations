(use-package auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  :ensure t
  :if (string= (system-name) "liutaodembp-310"))
