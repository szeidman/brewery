# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
Used rails-g to initiate file.
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
User has_many beers, beers and ingredients each have many beer ingredients.
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
Beers belongs_to user; Beer_Ingredients belong to Beer and Ingredient.
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
Beers and Ingredients has_many of each other through beer_ingredients.
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
Beer_ingredients.amount is user submittable.
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
User has Devise validations; beer and ingredients nave validations for all fields in forms; beer_ingredients has validations for Amount.
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
Ingredients have four class methods to filter down to each ingredient kind.
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
beer/new has fields for nested Ingredients.
- [x] Include signup (how e.g. Devise)
Implemented devise.
- [x] Include login (how e.g. Devise)
Implemented devise.
- [x] Include logout (how e.g. Devise)
Implemented devise.
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
Implemented devise with omniauth-facebook.
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
Beers/:id/ingredients implemented.
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
Beers/:id/ingredients/new implemented.
- [x] Include form display of validation errors (form URL e.g. /recipes/new)
Each form will display error messages after submit and 

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
