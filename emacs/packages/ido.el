(require 'ido)
(ido-mode 'buffers)
(setq ido-ignore-buffers
      '("^" "*Completions*" "*Shell Command Output*" "*Message*" "Async Shell Command"))
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
