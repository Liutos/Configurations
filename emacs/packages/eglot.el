(add-hook 'js-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs (cons 'js-mode (lambda (interactivep)
                                                     (list "localhost" 2089))))
