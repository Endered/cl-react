(load (merge-pathnames "jscl.lisp" (asdf:system-definition-pathname :jscl)))

(jscl:bootstrap)

(in-package :jscl)
(jscl:compile-application
 '("util.lisp"
   "dom.lisp"
   "react.lisp"
   "test.lisp"
   "5.lisp")
 "test.js")
