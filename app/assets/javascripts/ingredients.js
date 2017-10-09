$(function(){
  console.log("loaded")
  $(".see-ingredients-link").on('click', function(e){
    loadIngredients(e);
  })
  $(".js-next").on("click", function(event){
    Ingredient.showIngredient(event)
  })
})

//console.log(window.location.href)

function Ingredient(attributes) {
   this.id = attributes.id;
   this.name = attributes.name;
   this.kind = attributes.kind;
   this.origin = attributes.origin;
   this.beers = attributes.beers;
 }

function loadIngredients(e) {
  e.preventDefault();
  let dataID = $(".see-ingredients-link").attr("data-id");
  $.get(`/beers/${dataID}.json`, function (data) {
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: data.ingredients,
      beerId: data.id
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}

//get array of total ingredient IDs. Find length, find index number for data ID.
//function showIngredietsFromBeer

Ingredient.prototype.showIngredient = function () {
  e.preventDefault();
  let dataID = $(".js-next").attr("data-id");
  let nextID = ++dataID;
  let prevID = --dataID;
  $.get(`/beers/${dataID}.json`, function (data) {
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: data.ingredients,
      beerId: data.id
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}




// id="ingredients-index-list"
