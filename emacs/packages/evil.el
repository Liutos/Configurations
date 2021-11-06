(use-package evil
  :config
  (evil-mode 1)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (evil-set-initial-state 'image-mode 'emacs)
  (evil-set-initial-state 'slime-repl-mode 'emacs)
  (define-key evil-motion-state-map "/" 'swiper)
  (evil-define-key 'insert ledger-mode-map (kbd "<M-RET>") 'ledger-dup-account)
  ;; 在WSL中用K、J代替alt+上下箭头
  (when (eq system-type 'gnu/linux)
    (evil-define-key 'normal org-mode-map "K" 'org-metaup)
    (evil-define-key 'normal org-mode-map "J" 'org-metadown))
  ;; evil-mode相关的键绑定
  (evil-global-set-key 'motion (kbd "g 2") 'split-window-below)
  (evil-global-set-key 'motion (kbd "g 3") 'split-window-right)
  (evil-global-set-key 'motion (kbd "g b") 'ido-switch-buffer)
  (evil-global-set-key 'normal (kbd "g b") 'ido-switch-buffer)
  (evil-global-set-key 'normal (kbd "g f") 'ido-find-file)
  (evil-global-set-key 'normal (kbd "g o") 'org-clock-out)
  (when (featurep 'org-cuckoo)
    (evil-global-set-key 'normal (kbd "g s") 'org-cuckoo-schedule))
  (evil-global-set-key 'normal (kbd "g t") 'org-todo)
  (evil-global-set-key 'normal (kbd "f") 'evil-scroll-page-down)
  (evil-global-set-key 'normal (kbd "s") 'save-buffer)
  (when (eq system-type 'gnu/linux)
    (add-hook 'org-mode-hook
              (lambda ()
                (evil-local-set-key 'normal (kbd "TAB") 'org-cycle))))
  :ensure t)
