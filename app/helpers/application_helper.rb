module ApplicationHelper
  def ingredient_kinds
    ["hops", "yeast", "malt", "water"]
  end

  def ingredient_kinds_numbers(ingredient_kind)
    case ingredient_kind
    when "hops"
      0
    when "yeast"
      1
    when "malt"
      2
    when "water"
      3
    end
  end


end
