class BeerIngredient < ApplicationRecord
  belongs_to :beer, optional: true
  belongs_to :ingredient, optional: true

  validates_numericality_of :amount

end
