;;;; hack-assembler.asd
;;;;
;;;; Copyright (c) 2016 Fila Kolodny <fskolodny@gmail.com>

(asdf:defsystem #:hack-assembler
  :description "Describe hack-assembler here"
  :author "Fila Kolodny <fskolodny@gmail.com>"
  :license "MIT"
  :depends-on (
	       #:cl-ppcre
               #:iterate
	       )
  :serial t
  :components ((:file "package")
               (:file "hack-assembler")))

