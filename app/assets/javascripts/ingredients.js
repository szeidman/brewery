$(function(){
  $(".see-ingredients-link").click(function(e){
    loadIngredients(e);
  })
  $(".js-next").on("click", function(e){
    showNextIngredient(e)
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

function showNextIngredient(e) {
  e.preventDefault();
  let beerID = parseInt($(".js-next").attr("data-beer"));
  let ingredientID = parseInt($(".js-next").attr("data-ing"));
  if (beerID) {
    $.get(`/beers/${beerID}.json`, function (data) {
      let beerName = data.name;
      let ingredients = data.ingredients;
      let beerIngredients = data.beer_ingredients;
      //below should be functioned out
      let inArray = ingredients.find(ingredient => {
         return ingredient.id === ingredientID
       })
      let position = ingredients.indexOf(inArray);
      let nextPosition = ++position;
      let nextIngredient = ingredients[nextPosition] ? ingredients[nextPosition] : ingredients[0];
      let nextBeerIngredient = beerIngredients.find(beerIngredient => {
        return beerIngredient.ingredient_id === ingredientID
      });
      let nextAmount = nextBeerIngredient.amount;
      //Beers: get all the beers for an ingredient, then remove the current beer from the array. Register a handlebars helper.  ;
      let ingredientShow = HandlebarsTemplates['ingredients_show']({
        beer:   beerName,
        beerID: beerID,
        ingID:  nextIngredient.id,
        name:   nextIngredient.name,
        kind:   nextIngredient.kind,
        origin: nextIngredient.origin,
        amount: nextAmount
      });
      $(".show-ingredient").html(ingredientShow);
      $(".js-next").attr('data-ing', nextIngredient.id)
    });
  } else {
    $.get(`/ingredients.json`, function (data) {
      let ingredients = data;
      let inArray = ingredients.find(ingredient => {
         return ingredient.id === ingredientID
       })
      let position = ingredients.indexOf(inArray);
      let nextPosition = ++position;
      let nextIngredient = ingredients[nextPosition] ? ingredients[nextPosition] : ingredients[0];
      let ingredientShow = HandlebarsTemplates['ingredients_show']({
        ingID:  nextIngredient.id,
        name:   nextIngredient.name,
        kind:   nextIngredient.kind,
        origin: nextIngredient.origin,
        beers:  nextIngredient.beers
    });
    $(".show-ingredient").html(ingredientShow);
    $(".js-next").attr("data-ing", nextIngredient.id);
    });
  }
}




// id="ingredients-index-list"
