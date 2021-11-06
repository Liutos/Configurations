(require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))
(setq package-archives
      '(("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        ("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
(package-initialize)
