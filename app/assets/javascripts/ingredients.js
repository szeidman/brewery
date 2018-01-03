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
  let amount = (this.beerIngredients[0]) ? this.beerIngredients[0].amount : null;
  let beer = (this.beers[0]) ? this.beers[0].name : null;
  let ingredientsConfirm = HandlebarsTemplates['ingredients_confirm']({
    id: this.id,
    name: this.name,
    kind: this.kind,
    origin: this.origin,
    amount: amount,
    beer: beer
  });
  $('.new-ingredient').append(ingredientsConfirm)
}

Ingredient.error = function(resp){
  console.log("Error")
}

function loadIngredients(e) {
  e.preventDefault();
  let beerID = $(".see-ingredients-link").attr("data-beer-id");
  $.get(`/beers/${beerID}/ingredients.json`, function (ingredients) {
    let sortedIngredients = ingredients.sort((a,b) => a.name.localeCompare(b.name));
    let ingredientsList = HandlebarsTemplates['ingredients_list']({
      ingredients: sortedIngredients,
      beerId: beerID
    });
    $("#ingredients-index-list").html(ingredientsList)
  })
}

function showNextIngredient(e) {
  e.preventDefault();
  let beerID = $(".js-next").data("beer-id");
  let ingredientID = $(".js-next").data("ing-id");
  let ingredientIDs = $("#js-ingredient-ids").data("ingredient-ids");
  let position = ingredientIDs.indexOf(ingredientID);
  let nextPosition = ++position;
  let nextId = ingredientIDs[nextPosition] ? ingredientIDs[nextPosition] : ingredientIDs[0];
  if (beerID) {
    $.get(`/beers/${beerID}/ingredients/${nextId}.json`, function (data) {

      let ingredient = new Ingredient(data);

      let beer = ingredient.beers.find(beer => beer.id === beerID);
      let otherBeers = ingredient.beers.filter(beer => beer.id !== beerID);
      let beerIngredient = ingredient.beerIngredients.find(beerIngredient => beerIngredient.beer_id === beerID);

      let ingredientShow = HandlebarsTemplates['ingredients_show']({
        beerID:     beerID,
        beerName:   beer.name,
        otherBeers: otherBeers,
        ingID:      ingredient.id,
        name:       ingredient.name,
        kind:       ingredient.kind,
        origin:     ingredient.origin,
        amount:     beerIngredient.amount
      });
      $(".show-ingredient").html(ingredientShow);
      $(".js-next").data('ing-id', ingredient.id)
    });
  } else {
    $.get(`/ingredients/${nextId}.json`, function (data) {
      let ingredient = new Ingredient(data);

      let ingredientShow = HandlebarsTemplates['ingredients_show']({
        ingID:  ingredient.id,
        name:   ingredient.name,
        kind:   ingredient.kind,
        origin: ingredient.origin,
        beers:  ingredient.beers
    });
    $(".show-ingredient").html(ingredientShow);
    $(".js-next").data('ing-id', ingredient.id)
    });
  }
}
