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
   this.beerIngredients = attributes.beer_ingredients;
   this.beers = attributes.beers
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
    origin: this.origin,
    amount: this.beerIngredients[0].amount,
    beer: this.beers[0].name
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
    let ingredients = data.sort((a,b) => {return (a.name).localeCompare(b.name)});
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: ingredients,
      beerId: dataID
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}

function showNextIngredient(e) {
  e.preventDefault();
  let beerID = $(".js-next").data("beer");
  let ingredientID = $(".js-next").data("ing");
  let ingredientIDs = $("#js-ingredient-ids").data("ingredient-ids");
  let position = ingredientIDs.indexOf(ingredientID);
  let nextPosition = ++position;
  let nextId = ingredientIDs[nextPosition] ? ingredientIDs[nextPosition] : ingredientIDs[0];
  if (beerID) {
    $.get(`/beers/${beerID}/ingredients/${nextId}.json`, function (data) {
      // let beerName = data.name; change to data id array let ingredients = data;
      //let beerIngredients = data.beer_ingredients;find beer ingredient with beer id of beer id
      let ingredient = new Ingredient(data);
      function findBeerIngredientByID(beerIngredient) {
        return beerIngredient.beer_id === beerID;
      }
      function findBeerByID(beer) {
        return beer.id === beerID;
      }
      let beer = ingredient.beers.find(findBeerByID);
      let beerIngredient = ingredient.beerIngredients.find(findBeerIngredientByID);

      let ingredientShow = HandlebarsTemplates['ingredients_show']({
        //beer:   beerName,
        beerID:   beerID,
        beerName: beer.name,
        ingID:    ingredient.id,
        name:     ingredient.name,
        kind:     ingredient.kind,
        origin:   ingredient.origin,
        amount:   beerIngredient.amount
      });
      $(".show-ingredient").html(ingredientShow);
      $(".js-next").data('ing', ingredient.id)
    });
  } else {
    $.get(`/ingredients/${ingredientID}.json`, function (data) {
      debugger;
      let position = ingredientIDs.indexOf(ingredientID);
      let nextPosition = ++position;
      let nextId = ingredientIDs[nextPosition] ? ingredientIDs[nextPosition] : ingredientIDs[0];
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
