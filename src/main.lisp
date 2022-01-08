(defpackage :cl-react
    (:use :cl)
  (:export :deploy))

(in-package :cl-react)

;; Can not load the jscl by asdf:load-system because implementations. So this load via strange way
;; asdf:load-systemはjsclの実装の関係上上手く動かないので少し変な方法でロードしてます。
(load (merge-pathnames "jscl.lisp" (asdf:system-definition-pathname :jscl)))

(let ((evaled nil))
  (defun bootstrap ()
    (unless evaled
      (setf evaled t)
      (jscl:bootstrap))))

(defvar *jscl-headers*
  (mapcar (lambda (file)
	    (uiop:merge-pathnames*
	     file
	     cl-react.config:*jscl-headers-root*))
	  (list "dom.lisp"
		"react.lisp"
		"util.lisp")))

(defun deploy (compile-files deploy-file-name)
  "compile compile-files and output to deploy-file-name"
  (bootstrap)
  (in-package :jscl)
  (jscl:compile-application
   (append *jscl-headers*
	   compile-files)
   deploy-file-name))
