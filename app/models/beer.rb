class Beer < ApplicationRecord
  belongs_to :user
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients
  accepts_nested_attributes_for :ingredients

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :style
  validates_numericality_of :abv, greater_than_or_equal_to: 0, less_than: 15
  validates_numericality_of :ibu, only_integer: true, greater_than_or_equal_to: 0, less_than: 150
  validates_numericality_of :srm, greater_than_or_equal_to: 1.0, less_than: 20.1
  validate :amount_check

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.each do |ingredient_attribute|
      ingredient = Ingredient.find_by(name: ingredient_attribute[:name])
      if ingredient
        if self.beer_ingredients.find_by(ingredient_id: ingredient.id)
          beer_ingredient = self.find_beer_ingredient(ingredient.id)
          beer_ingredient.update(amount: ingredient_attribute[:amount])
        else
          old_ingredient = self.ingredients.find_by(kind: ingredient.kind)
          if old_ingredient
            old_beer_ingredient = self.beer_ingredients.find_by(ingredient_id: old_ingredient.id)
            old_beer_ingredient.update(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
          else
            self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
          end
        end
      else
        ingredient = self.ingredients.build(name: ingredient_attribute[:name], origin: ingredient_attribute[:origin], kind: ingredient_attribute[:kind])
        old_ingredient = self.ingredients.find_by(kind: ingredient_attribute[:kind])
        if old_ingredient
          old_beer_ingredient = self.beer_ingredients.find_by(ingredient_id: old_ingredient.id)
          old_beer_ingredient.delete
          save_ingredient_create_beer_ingredient(ingredient, ingredient_attribute)
        else
          save_ingredient_create_beer_ingredient(ingredient, ingredient_attribute)
        end
      end
    end
  end

  def amount_check
    self.beer_ingredients.each do |beer_ingredient|
      if beer_ingredient.amount == nil
        errors.add(:base, "Amount for #{kind_for_amount(beer_ingredient)} can't be blank")
      elsif beer_ingredient.amount.to_f <= 0
        errors.add(:base, "Amount for #{kind_for_amount(beer_ingredient)} must be a number greater than zero")
      end
    end
  end

  def kind_for_amount(beer_ingredient)
    if Ingredient.find_by(id: beer_ingredient.ingredient_id)
      Ingredient.find_by(id: beer_ingredient.ingredient_id).kind
    else
      "ingredient"
    end
  end

  def find_beer_ingredient(ingredient_id)
    self.beer_ingredients.find_by(ingredient_id: ingredient_id)
  end

  def find_beer_ingredient_amount(kind)
    ingredient = self.ingredients.find_by(kind: kind)
    if ingredient
      beer_ingredient = self.find_beer_ingredient(ingredient.id)
      beer_ingredient.amount
    end
  end

  def find_beer_ingredient_name(kind)
    ingredient = self.ingredients.find_by(kind: kind)
    if ingredient
      beer_ingredient = self.find_beer_ingredient(ingredient.id)
      beer_ingredient.name
    end
  end

  def save_ingredient_create_beer_ingredient(ingredient, ingredient_attribute)
    ingredient.save
    self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
  end

  def color
    if self.srm < 3.0
      "Pale Yellow"
    elsif self.srm < 4.5
      "Medium Yellow"
    elsif self.srm < 7.5
      "Gold"
    elsif self.srm < 9.0
      "Amber"
    elsif self.srm < 11.0
      "Copper"
    elsif self.srm < 14.0
      "Red/Brown"
    elsif self.srm < 19.0
      "Brown"
    else
      "Black"
    end
  end

  def bitter
    if self.ibu < 22
      "Mellow"
    elsif self.ibu < 38
      "Reasonably bitter"
    elsif self.ibu < 75
      "Getting hoppier"
    elsif self.ibu < 90
      "Strong hoppiness"
    else
      "Not for the uninitiated"
    end
  end

  def alcohol
    if self.abv > 9.5
      "It'll getcha drunk"
    elsif self.abv > 6.5
      "Lotsa booze"
    elsif self.abv > 5.5
      "More than average"
    elsif self.abv > 4.5
      "Average"
    elsif self.abv > 3.5
      "Sessionable"
    else
      "Near beer"
    end
  end

end
