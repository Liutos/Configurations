;; Python 的 major mode 与 eglot 都是 Emacs 29 内置的，只需把 pyright 接上，
;; 即可获得 M-. 跳转定义、M-, 跳回、代码补全与实时类型检查
(use-package python-mode
  :hook (python-mode . eglot-ensure))
