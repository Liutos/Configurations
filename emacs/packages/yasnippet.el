;;; package-install yasnippet
;;; package-install yasnippet-snippets
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
