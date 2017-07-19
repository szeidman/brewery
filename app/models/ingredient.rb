class Ingredient < ApplicationRecord
  has_many :beer_ingredients
  has_many :beers, through: :beer_ingredients
  #refactor into metaprogramming to populate
  scope :malt, -> { where(kind: 'malt') }
  scope :yeast, -> { where(kind: 'yeast') }
  scope :hops, -> { where(kind: 'hops') }
  scope :water, -> { where(kind: 'water') }
end
