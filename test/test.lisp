(define-function-component hoge "Hoge"
  ()
  (let* ((count-state (use-state 0))
	 (count (car count-state))
	 (set-count (cdr count-state)))
    (div ()
	 (div () (p () (format nil "You clicked ~a times" count)))
	 (button `(("onClick" . ,(no-argument
				  (lambda () (funcall set-count
						      (+ count 1))))))
		 "Click Me"))))

(define-function-component formapp "FormApp"
  ()
  (let* ((value-state (use-state ""))
	 (message-state (use-state ""))
	 (value (car value-state))
	 (set-value (cdr value-state))
	 (message (car message-state))
	 (set-message (cdr message-state)))
    (labels ((handle-input (obj)
	       (funcall set-value
			(oget obj "target" "value")))
	     (send ()
	       (funcall set-message value)
	       (funcall set-value "")))
      (div ()
	   (input `(,(cons "type" "text")
		    ("value" . ,value)
		    ("onChange" . ,(one-argument #'handle-input))))
	   (button `(("onClick" . ,(no-argument #'send))) "SEND")
	   (div () message)))))

(react-dom-render
 (formapp ())
 (get-element-by-id "root"))
