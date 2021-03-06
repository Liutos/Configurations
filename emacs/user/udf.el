(defun lt-due-today ()
  "Search tasks due today."
  (interactive)
  (let* ((s (shell-command-to-string "date +'%Y-%m-%d'"))
         (length (length s))
         (date (substring s 0 (- length 1))))
    (projectile-ag date)))

(defun lt-cd-org ()
  "Find things under ~/src/org/ directory."
  (interactive)
  (let ((default-directory "~/src/org/"))
    (call-interactively 'find-file)))

(defun lt-cd-shefenqi ()
  "Find things under shefenqi/node/ directory."
  (interactive)
  (let ((default-directory "~/src/shefenqi/node/"))
    (call-interactively 'find-file)))

(defun lt-cd-tmp ()
  "Find things under /mnt/shared/tmp/ directory."
  (interactive)
  (let ((default-directory "/mnt/shared/tmp/"))
    (call-interactively 'find-file)))
