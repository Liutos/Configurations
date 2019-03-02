(defun lt-cd-shefenqi ()
  "Find things under shefenqi/node/ directory."
  (interactive)
  (let ((default-directory "~/Documents/Shefenqi/Projects/"))
    (call-interactively 'find-file)))
(global-set-key "\C-c\C-f" 'lt-cd-shefenqi)
