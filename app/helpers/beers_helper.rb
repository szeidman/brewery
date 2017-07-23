module BeersHelper
  def selected?(ingredient_name)
    if @beer.ingredients.find_by(name: ingredient_name)
      "selected"
    else
      ""
    end
  end
end
