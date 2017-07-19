class Ingredient < ApplicationRecord
  has_many :beer_ingredients
  has_many :beers, through: :beer_ingredients
end
