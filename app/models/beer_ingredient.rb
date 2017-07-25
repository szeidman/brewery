class BeerIngredient < ApplicationRecord
  belongs_to :beer
  belongs_to :ingredient

  validates_numericality_of :amount, greater_than_or_equal_to: 0
  validates_presence_of :amount

end
