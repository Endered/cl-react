(defmacro awhen (expr &body body)
  `(let ((it ,expr))
     (when it ,@body)))

(defun list->js-array (list)
  (let ((res (#j:Array)))
    (mapc (lambda (v) ((oget res "push") v))
	  list)
    res))

(defun js-object-assign (destination source)
  (#j:Object:assign destination source))

(defun make-js-array (x)
  (cond ((arrayp x)
	 x)
	((listp x)
	 (list->js-array x))
	(t
	 (list->js-array (list x)))))

(defun flat-list (list)
  (let ((res nil))
    (labels ((rec (lst)
	       (cond ((null lst))
		     ((listp lst)
		      (rec (car lst))
		      (rec (cdr lst)))
		     (t
		      (push lst res)))))
      (rec list)
      (reverse res))))


(defun hash-table->js-object (hash-table)
  (let ((res (new)))
    (maphash (lambda (key val)
	       (setf (oget res key) val))
	     hash-table)
    res))

(defun js-object->hash-table (js-object)
  (let ((res (make-hash-table :test #'equal)))
    (loop for k across (#j:Object:keys js-object)
	  for key = (string k)
	  collect (setf (gethash key res)
			(oget js-object key)))
    res))


(defun hash-table->list (hash-table)
  (let ((res nil))
    (maphash (lambda (key value)
	       (push (cons key value) res))
	     hash-table)
    res))

(defun list->hash-table (list)
  (let ((res (make-hash-table :test #'equal)))
    (mapcar (lambda (cons)
	      (setf (gethash (car cons) res)
		    (cdr cons)))
	    list)
    res))

(defun list->js-object (list)
  (hash-table->js-object
   (list->hash-table list)))

(defun js-object (&optional (attr nil))
  (cond ((listp attr)
	 (list->js-object attr))
	((hash-table-p attr)
	 (hash-table->js-object attr))
	(t attr)))

(defun array-or-one (x)
  (cond ((arrayp x)
	 x)
	((listp x)
	 (make-js-array x))
	(t
	 x)))

(defun js-map (f js-object)
  (when (listp js-object) (setf js-object (list->js-array js-object)))
  (let ((keys (#j:Object:keys js-object)))
    (format t "keys: ~a" keys)
    (loop for key across keys
	  for key-string = (string key)
	  collect (funcall f (oget js-object key-string)
			   key-string))))

(defun js-key-map (f js-object)
  (when (listp js-object) (setf js-object (list->js-array js-object)))
  (let ((keys (#j:Object:keys js-object)))
    (loop for key across keys
	  for key-string = (string key)
	  collect (funcall f key-string))))

(defun js-value-map (f js-object)
  (when (listp js-object) (setf js-object (list->js-array js-object)))
  (let ((keys (#j:Object:keys js-object)))
    (loop for key across keys
	  for key-string = (string key)
	  for value = (oget js-object key-string)
	  collect (funcall f value))))

(defun valid-string (str)
  (let ((res  (format nil "~a" str)))
    (dotimes (i (length res))
      (setf (aref res i) (char-downcase (aref res i)))
      (when (eq #\space (aref res i)) (setf (aref res i) #\_)))
    res))

(defun n-argument (n func)
  (let* ((vars (loop for i from 1 to n
		     collect (format nil "v~a" i)))
	 (vars (list->js-array vars))
	 (str ((oget vars "join"))))
    (funcall (#j:eval (format nil "f => (~a) => f(~a)"
			      str str)) 
	     func)))

(defun no-argument (func)
  (n-argument 0 func))

(defun one-argument (func)
  (n-argument 1 func))
