(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq-default ac-sources
              '(ac-source-words-in-same-mode-buffers))
(setq ac-auto-start 3)
(setq ac-auto-show-menu 0.7)
