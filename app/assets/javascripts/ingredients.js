$(function(){
  $(".see-ingredients-link").click(function(e){
    loadIngredients(e);
  })
  $(".js-next").on("click", function(e){
    showNextIngredient(e)
  })
  $("form#new_ingredient").on("submit", Ingredient.formSubmit)
})

//console.log(window.location.href)

function Ingredient(attributes) {
   this.id = attributes.id;
   this.name = attributes.name;
   this.kind = attributes.kind;
   this.origin = attributes.origin;
 }

Ingredient.formSubmit = function(e){
  e.preventDefault();
  var $form = $(this);
  var action = $form.attr("action");
  var params = $form.serialize();

  $.ajax({
    url: action,
    data: params,
    dataType: "json",
    method: "POST"
  })
    .success(Ingredient.success)
    .error(Ingredient.error)
}

Ingredient.success = function(json){
  //TODO: Add code to parse the json if a new ingredient from a beer is made.
  //beer.ingredient_attributes.[amount, etc.]
  let errorMessages = json.error_messages;
  let errorType = json.error_type;

  $('#error_explanation h4').text('');
  $('#error_explanation ul').html('');
  $('#new_ingredient label').each(function(){
    $(this).removeClass('field_with_errors')
  });

  if (errorMessages) {
    let count = errorMessages.length;
    if (count > 1) {
      plural = 'errors'
    } else {
      plural = 'error'
    }
    $('#error_explanation h4').text(count + ' ' + plural + ' kept this ingredient from saving:');
    for (err in errorMessages) {
      $('#error_explanation ul').append('<li>' + errorMessages[err] + '</li>');
    };
    let errorFirsts = [];
    for (let i=0;i<errorMessages.length;i++) {
      let first = errorMessages[i].split(" ");
      errorFirsts.push(first[0]);
      };
    $('#new_ingredient label').each(function(){
      if (errorFirsts.includes(this.innerText)) {
        $(this).addClass('field_with_errors')
      }
    });
    $("form#new_ingredient input:submit").prop('disabled', false);
  } else {
    let last = json[3];
    let forNew = (last) ? last : json;
    let ingredient = new Ingredient(forNew);
    ingredient.renderConfirm();
    $("form#new_ingredient").each(function(){
      this.reset();
    });
    $("form#new_ingredient input:submit").prop('disabled', false);
    $("form#new_ingredient input:submit").prop('value', 'Create Another Ingredient');
  }
}

Ingredient.prototype.renderConfirm = function() {
  let ingredientsConfirm = HandlebarsTemplates['ingredients_confirm']({
    id: this.id,
    name: this.name,
    kind: this.kind,
    origin: this.origin
  });
  $('.new-ingredient').append(ingredientsConfirm)
}

Ingredient.error = function(resp){
  console.log("Error")
}

function loadIngredients(e) {
  e.preventDefault();
  let dataID = $(".see-ingredients-link").attr("data-id");
  $.get(`/beers/${dataID}/ingredients.json`, function (data) {
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: data,
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}

function showNextIngredient(e) {
  e.preventDefault();
  let beerID = parseInt($(".js-next").attr("data-beer"));
  let ingredientID = parseInt($(".js-next").attr("data-ing"));
  if (beerID) {
    $.get(`/beers/${beerID}.json`, function (data) {
      let beerName = data.name;
      let ingredients = data.ingredients;
      let beerIngredients = data.beer_ingredients;

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

      //TODO: Beers: get all the beers for an ingredient, then remove the current beer from the array. Register a handlebars helper to handle logic.

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
      let ingredients = data.sort((a,b) => {return (a.name).localeCompare(b.name)});
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
