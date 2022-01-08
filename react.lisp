(defun react-create-element (tag props &rest child-elements)
  (apply
   #j:React:createElement
   tag
   (become-js-object props)
   (mapcar #'array-or-one child-elements)))

(defun become-js-object (x)
  (cond ((hash-table-p x) (hash-table->js-object x))
	((listp x) (hash-table->js-object
		    (list->hash-table x)))
	(t x)))

(defun become-hash-table (x)
  (js-object->hash-table (become-js-object x)))

(defmacro create-jsx-tag (tag tag-name)
  `(defun ,tag (props &rest child-elements)
     (apply #'react-create-element ,tag-name props child-elements)))

(create-jsx-tag ul "ul")
(create-jsx-tag li "li")
(create-jsx-tag div "div")
(create-jsx-tag section "section")
(create-jsx-tag h1 "h1")
(create-jsx-tag h2 "h2")
(create-jsx-tag p "p")
(create-jsx-tag article "article")
(create-jsx-tag header "header")
(create-jsx-tag button "button")
(create-jsx-tag input "input")

(defun react-dom-render (element root-node)
  (#j:ReactDOM:render
   (array-or-one element)
   root-node))

(defmacro define-function-component (tag tag-name arg &body body)
  (let ((func (gensym))
	(args (gensym)))
    `(progn
       (defun ,func (props &rest ,args)
	 (let ,(mapcar (lambda (attr)
			 `(,(car attr) (oget props ,@ (cdr attr))))
		arg)
	   ,@body))
       (create-jsx-tag ,tag #',func)
       (setf (oget *root* ,tag-name) (lambda (props &rest ,args)
				       (apply #',func props other))))))




(defun use-state (initial-value)
  (let ((res (#j:React:useState initial-value)))
    (cons (oget res "0") (oget res "1"))))
