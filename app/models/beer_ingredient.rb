class BeerIngredient < ApplicationRecord
  belongs_to :beer
  belongs_to :ingredient

  validates_numericality_of :amount
  
end
