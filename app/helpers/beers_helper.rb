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
    elsif instance_variable_get("@#{ingredient_kind}")
      instance_variable_get("@#{ingredient_kind}").beer_ingredients.first.amount
    else
      ""
    end
  end

end
