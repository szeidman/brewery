class Ingredient < ApplicationRecord
  has_many :beer_ingredients
  has_many :beers, through: :beer_ingredients
  accepts_nested_attributes_for :beer_ingredients
  accepts_nested_attributes_for :beers

  validate :amount_check
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :origin
  validates_presence_of :kind, message: "must be selected"


  #refactor into metaprogramming to populate
  scope :malt, -> { where(kind: 'malt') }
  scope :yeast, -> { where(kind: 'yeast') }
  scope :hops, -> { where(kind: 'hops') }
  scope :water, -> { where(kind: 'water') }

  def amount_check
    self.beer_ingredients.each do |beer_ingredient|
      if beer_ingredient.amount == nil
        errors.add(:base, "Amount can't be blank")
      elsif beer_ingredient.amount.to_i <= 0
        errors.add(:base, "Amount must be a number greater than zero")
      end
    end
  end

end
