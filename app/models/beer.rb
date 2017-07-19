class Beer < ApplicationRecord
  belongs_to :user
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients
end
