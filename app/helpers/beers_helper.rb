module BeersHelper
  def selected?(ingredient_name)
    if @beer.ingredients.find_by(name: ingredient_name)
      "selected"
    else
      ""
    end
  end


  def beer_ingredient_amount(ingredient_kind)
    if @beer.find_beer_ingredient_amount(ingredient_kind)
      @beer.find_beer_ingredient_amount(ingredient_kind)
    else
      @beer.beer_ingredients[ingredient_kinds_numbers(ingredient_kind)].amount
    end
  end

end
