$(function(){
  $(".see-ingredients-link").click(function(event){
    loadIngredients(event);
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






// id="ingredients-index-list"