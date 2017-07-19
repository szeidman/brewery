class BeerIngredient < ApplicationRecord
  belongs_to :beer
  belongs_to :ingredient
end
