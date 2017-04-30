(load-file "~/installer/file-template.el")
(autoload 'file-template-auto-insert "file-template" nil t)
(setq file-template-insert-automatically 'ask)
(autoload 'file-template-find-file-not-found-hook "file-template" nil t)
(add-hook 'find-file-not-found-hooks 'file-template-find-file-not-found-hook 'append)
(add-to-list 'file-template-mapping-alist
             '("\\.asd" . "~/.emacs.d/user/template/template.asd"))
