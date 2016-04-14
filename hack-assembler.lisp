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

(defun strip-comments (line)
  (cl-ppcre:regex-replace "//.*$" line (make-string 0))
  )
(defun read-assembly-file (path)
  (with-open-file (asm path)
    (let ((lines
	    (iter
	      (for line in-stream asm using 'read-line)	      
	      (setf line (strip-comments line))
	      (multiple-value-bind (success result)
		  (cl-ppcre:scan-to-strings "^\\s*(\\S.*?)?\\s*$" line)
		(if success
		    (setf line (aref result 0)))
		)
	      (if (zerop (length line))
		  (next-iteration))
	      (collect line)
	      ))
	  )
      lines
      )
    )
  )

(defun assemble (file)
  (let (
	(lines (read-assembly-file file))
	)
    (iter
     (for line in lines)
     (case (char line 0)
       (#\( (write (subseq line 1 (1- (length line)))))
       (#\@ (make-instance 'a-instruction :address (parse-integer line :start 1)))
       )
     )
    )
  )
