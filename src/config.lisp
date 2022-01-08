(defpackage :cl-react.config
  (:use :cl)
  (:export :*project-root*
	   :*jscl-headers-root*))

(in-package :cl-react.config)

(defvar *project-root*
  (asdf:system-source-directory :cl-react))

(defvar *jscl-headers-root*
  (uiop:merge-pathnames* "src/jscl/" *project-root*))
