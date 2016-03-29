;;;; hack-assembler.lisp
;;;;
;;;; Copyright (c) 2016 Fila Kolodny <fskolodny@gmail.com>

(in-package #:hack-assembler)

;;; "hack-assembler" goes here. Hacks and glory await!
(defclass a-instruction ()
  ((address :initarg :address :accessor address :type (unsigned-byte 15))
   )
  )

(defmethod print-object ((object a-instruction) stream)
  (format stream "0~15,'0B" (address object))
  )

(defclass c-instruction ()
  ((usea :initarg :usea :accessor usea :type (unsigned-byte 1))
   (c-bits :initarg :cbits :accessor c-bits :type (unsigned-byte 6))
   (destination :initarg :dest :accessor dest :type (unsigned-byte 3))
   (jump :initarg :jump :accessor jump :type (unsigned-byte 3))
   )
  )

(defmethod print-object ((object c-instruction) stream)
  (format stream "111~B~6,'0B~3,'0B~3,'0B" (usea object) (c-bits object)
	  (dest object) (jump object))
  )
