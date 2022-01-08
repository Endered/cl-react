(defsystem :cl-react
  :author "endered"
  :license ""
  :components
  ((:module "src"
    :components
    ((:file "main" :depends-on ("config"))
     (:file "config")))))
