$(function(){
  $("#see-ingredients-link").click(function(event){
    loadIngredients(event);
  })
})

//console.log(window.location.href)

// function Ingredient(attributes) {
//   this.id = attributes.id;
//   this.name = attributes.name;
//   this.kind = attributes.kind;
//   this.origin = attributes.origin;
//   this.beers = [];
//
//   //attributes.beers push each beer
//
// }
//
// Ingredient.prototype.renderLI = function(){
// }
//
// $("see-ingredients-link")

function loadIngredients(e) {
  e.preventDefault();
  $.get(window.location.href + '.json', function (data) {
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: data.ingredients
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}




// id="ingredients-index-list"
