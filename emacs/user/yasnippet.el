(add-to-list 'load-path
             "~/app/yasnippet-master/")
(require 'yasnippet)
(yas-global-mode 1)
(let ((file "~/.emacs.d/elpa/yasnippet-20161221.1953/snippets"))
  (when (file-exists-p file)
    (yas-load-directory "~/.emacs.d/elpa/yasnippet-20161221.1953/snippets")))
