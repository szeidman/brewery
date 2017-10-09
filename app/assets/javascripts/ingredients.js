$(function(){
  $(".see-ingredients-link").on('click', function(e){
    loadIngredients(e);
  })
  $(".js-next").on("click", function(e){
    showIngredient(e)
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

function showIngredient(e) {
  e.preventDefault();
  let beerID = $(".js-next").attr("data-beer");
  let ingredientID = $(".js-next").attr("data-ing");
  let amount = $(".js-next").attr("data-amount");
  debugger;
}




// id="ingredients-index-list"
