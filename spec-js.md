# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
jQuery support is added to the layout and is used throughout Ingredients.js.
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
Renders Ingredient show pages with jquery get requests and updates via Handlebars template.
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
Renders an Ingredients index for a particular Beer on that Beer's show page.
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
Each Beer has_many ingredients, which is incorporated into the Beer Ingredients index page and to the Beer Ingredient show page.
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.
New Ingredient form submission is hijacked by an Ajax POST request that processes the response, handling errors or, on success, rendering the response in the DOM.
- [x] Translate JSON responses into js model objects.
An Ingredient model object has been set up to take in the JSON response of the above.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
The Ingredient model objects have a prototype method, renderConfirm, that takes in properties of the model object and appends them in a specific format to the DOM.
Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
