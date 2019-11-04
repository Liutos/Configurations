;;; package-install yasnippet
;;; package-install yasnippet-snippets
(require 'yasnippet)
(yas-reload-all)
(add-hook 'ledger-mode-hook #'yas-minor-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'restclient-mode-hook #'yas-minor-mode)
