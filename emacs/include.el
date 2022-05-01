;;; 将路径添加到load-path中
(require 'package)
(package-initialize)

(setq package-archives
      '(("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

(defun ensure-load-path-exists (dir)
  "向LOAD-PATH中添加目录DIR——如果还没有添加的话。"
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)))

(when (eq system-type 'darwin)
  (add-to-list 'load-path "/Users/liutos/Dropbox/SourceCode/elisp/")
  (add-to-list 'load-path "~/Projects/cuckoo/contrib/emacs/")
  (add-to-list 'load-path "~/Projects/tern-master/emacs/")
  (add-to-list 'load-path "~/.emacs.d/themes/")
  (add-to-list 'load-path "/Users/liutos/Projects/parse-faq-org/contrib/emacs/")
  (ensure-load-path-exists "~/Projects/Configurations/emacs/lib/")
  (ensure-load-path-exists "~/Projects/fledgling/contrib/emacs/"))

(when (eq system-type 'gnu/linux)
  (add-to-list 'load-path "~/SourceCode/elisp/")
  (add-to-list 'load-path "~/Applications/cuckoo/contrib/emacs/")
  (add-to-list 'load-path "~/.emacs.d/themes/"))

(require 'use-package)

;;; 其它需要require的内容
(require 'uniquify)
(load-file "~/Projects/Configurations/emacs/packages/avy.el")
(load-file "~/Projects/Configurations/emacs/packages/company.el")
(load-file "~/Projects/Configurations/emacs/packages/dashboard.el")
(load-file "~/Projects/Configurations/emacs/packages/diff-hl.el")
(load-file "~/Projects/Configurations/emacs/packages/dimmer.el")
(load-file "~/Projects/Configurations/emacs/packages/evil.el")
(load-file "~/Projects/Configurations/emacs/packages/flycheck.el")
(load-file "~/Projects/Configurations/emacs/packages/helm.el")
(load-file "~/Projects/Configurations/emacs/packages/helm-swoop.el")
(load-file "~/Projects/Configurations/emacs/packages/helpful.el")
(load-file "~/Projects/Configurations/emacs/packages/idle-highlight.el")
(load-file "~/Projects/Configurations/emacs/packages/ido.el")
(load-file "~/Projects/Configurations/emacs/packages/ledger.el")
(require 'cl)
(require 'org-cuckoo nil t)
(load-file "~/Projects/Configurations/emacs/packages/magit.el")
(load-file "~/Projects/Configurations/emacs/packages/magit-todos.el")
(load-file "~/Projects/Configurations/emacs/packages/markdown.el")
(load-file "~/Projects/Configurations/emacs/packages/org.el")
(require 'org-fledgling)
(load-file "~/Projects/Configurations/emacs/packages/paredit.el")
(load-file "~/Projects/Configurations/emacs/packages/powerline.el")
(load-file "~/Projects/Configurations/emacs/packages/projectile.el")
(load-file "~/Projects/Configurations/emacs/packages/rainbow-delimiters.el")
(load-file "~/Projects/Configurations/emacs/packages/restclient.el")
(load-file "~/Projects/Configurations/emacs/packages/slime.el")
(load-file "~/Projects/Configurations/emacs/packages/smex.el")
(load-file "~/Projects/Configurations/emacs/packages/swiper.el")
(load-file "~/Projects/Configurations/emacs/packages/switch-window.el")
(load-file "~/Projects/Configurations/emacs/packages/uuidgen.el")
(load-file "~/Projects/Configurations/emacs/packages/wakatime.el")
(load-file "~/Projects/Configurations/emacs/packages/wgrep.el")
(load-file "~/Projects/Configurations/emacs/packages/yasnippet.el")
(use-package request
  :ensure t)
(require 'org-refile-eof nil t)
(when (eq system-type 'darwin)
  (require 'org-tempo))
(require 'parse-faq-org nil t)

