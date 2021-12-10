(defun data ()
  (list
   (js-object
    (list
     (cons "name" "Baked Salmon")
     (cons
      "ingredients"
      (list
       (js-object '(("name" . "Salmon") ("amount" . 1)
		    ("measurement" . "l lb")))
       (js-object '(("name" . "Pine Nuts") ("amount" . 1)
		    ("measurement" . "cup")))
       (js-object '(("name" . "Butter Lettuce") ("amount" . 2)
		    ("measurement" . "cups")))
       (js-object '(("name" . "Yellow Squash") ("amount" . 1)
		    ("measurement" . "med")))
       (js-object '(("name" . "Olive Oil") ("amount" . 0.5)
		    ("measurement" . "cup")))
       (js-object '(("name" . "Garlic") ("amount" . 3)
		    ("measurement" . "cloves")))))
     (cons "steps"
	   '("Preheat the oven to 350 degrees."
	     "Spread the olive oil around a glass baking dish."
	     "Add the salmon, garlic, and pine nuts to the dish."
	     "Bake for 15 minutes."
	     "Add the yellow squash and put back in the oven for 30 mins."
	     "Remove from oven and let cool for 15 minutes. Add the lettuce and serve."))))
   (js-object
    (list
     (cons "name" "Fish Tacos")
     (cons "ingredients"
	   (list
	    (js-object '(("name" . "Whitefish") ("amount" . 1)
			 ("measurement" . "l lb")))
	    (js-object '(("name" . "Cheese") ("amount" . 1)
			 ("measurement" . "cup")))
	    (js-object '(("name" . "Iceberg Lettuce") ("amount" . 2)
			 ("measurement" . "cups")))
	    (js-object '(("name" . "Tomatoes") ("amount" . 2)
			 ("measurement" . "large")))
	    (js-object '(("name" . "Tortillas") ("amount" . 3)
			 ("measurement" . "med")))))
     (cons "steps"
	   '("Cook the fish on the grill until hot."
	     "Place the fish on the 3 tortillas."
	     "Top them with lettuce, tomatoes, and cheese"))))))


(define-function-component menu "Menu" ; menu関数をJS側では"Menu"という名前で宣言
  ((title "title") (recipes "recipes")) ; title = props.title, recipes = props.recipes
  (article ; <article>
   ()
   (header ; <header>
    ()
    (h1 () title)) ; <h1>{title}</h1></header>
   (div '(("className" . "recipes")) ; <div className="recipes">
	(js-map (lambda (recipe index) ; Object.Keys(recipes).map((recipe,index) => 
		  (recipe (append `(("key" . ,index)) ; <recipe {key:index, ...recipe}/>
				  (js-map (lambda (a b) (cons b a))
					  recipe))))
		recipes)))) ; </div></article>

(define-function-component recipe "Recipe"
    ((name "name") (ingredients "ingredients") (steps "steps"))
  (section `(("id" . ,(valid-string name)))
	   (h1 () name)
	   (ul '(("className" . "ingredients"))
	       (js-map
		(lambda (ingredient i)
		  (li `(("key" . ,i)) (oget ingredient "name")))
		ingredients))
	   (section '(("className" . "instructions"))
		    (h2 () "Cooking Instructions")
		    (js-map (lambda (step i)
			      (p `(("key" . ,i)) step))
			    steps))))

(when t
  (let ((object
	  (menu (list (cons "recipes" (data))
		      (cons "title" "Delicious Recipes")))))
   (react-dom-render
    object
    (get-element-by-id "root")))
  nil)
