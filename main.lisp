(load (merge-pathnames "jscl.lisp" (asdf:system-definition-pathname :jscl)))

(jscl:bootstrap)


(defun deploy ()
  (in-package :jscl)
  (jscl:compile-application
   '("util.lisp"
     "dom.lisp"
     "react.lisp"
     "test/test.lisp")
   "test/test.js"))

#-swank
(deploy)
