(defun ingredients-list (items)
  (loop for i from 0
	for ingredient in items
	collect (li `(("key" . ,i)) ingredient)))

(react-dom-render
 (section
  '(("id" . "backend-salmon"))
  (h1 () "Baked Salmon")
  (ul
   '(("className" . "ingredients"))
   (ingredients-list
    (list "2 lb salmon"
	  "5 sprigs fresh rosemary"
	  "2 tablespoons olive oil"
	  "2 small lemons"
	  "1 teaspoon kosher salt"
	  "4 cloves of chopped garlic")))
  (section
   '(("className" . "instructions"))
   (h2 () "Cooking Instructions")
   (p () "Preheat the oven to 375 degrees.")
   (p () "Lightly coat aluminum foil with oil.")
   (p () "Place salmon on foil.")
   (p ()
      "Cover with rosemary, sliced lemons, chopped garlic.")
   (p ()
      "Bake for 15-20 minutes until cooked through.")
   (p () "Remove from oven.")))
 (get-element-by-id "root"))


(defun square (x)
  (* x x))
;;; function(x){
;;;     return x * x;
;;; }
