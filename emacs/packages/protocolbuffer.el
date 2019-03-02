;; package-install protobuf-mode
(defconst my-protobuf-style
  '((c-basic-offset . 2)))
(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" 'my-protobuf-style t)))
