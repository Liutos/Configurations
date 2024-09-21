(use-package evil
  :config
  (evil-mode 1)
  (let ((mode-list
	 '(dired-mode
	   eshell-mode
	   image-mode
	   rg-mode
	   slime-repl-mode)))
    (dolist (mode mode-list)
      (evil-set-initial-state mode 'emacs)))
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
  (add-hook 'org-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "TAB") 'org-cycle)))
  (add-hook 'org-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "c") 'simulate-C-c)))
  (add-hook 'slime-mode-hook
            (lambda ()
              (evil-local-set-key 'normal (kbd "g d") 'slime-edit-definition)))
  :ensure t)
