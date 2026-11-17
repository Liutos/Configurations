;; -*- lexical-binding: t; -*-
;;; M-x package-install company
(use-package company
  :config
  (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0.3)
  (add-hook 'ledger-mode-hook #'company-mode)
  (add-hook 'org-mode-hook #'company-mode)
  (add-hook 'prog-mode-hook #'company-mode)
  :ensure t)
