class Beer < ApplicationRecord
  belongs_to :user
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :style
  validates_numericality_of :abv
  validates_numericality_of :ibu
  validates_numericality_of :srm



  #validate that all types of ingredients included: does that but need to customize
  #@messages={:beer_ingredients=>["is invalid"]}, @details={:beer_ingredients=>[{:error=>:invalid}, {:error=>:invalid}, {:error=>:invalid}, {:error=>:invalid}]}>

  scope :darkest, -> { where(kind: 'water') }

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.each do |ingredient_attribute|
      ingredient = Ingredient.find_by(name: ingredient_attribute[:name])
        if ingredient
          if self.find_beer_ingredient(ingredient.id)
            beer_ingredient = self.find_beer_ingredient(ingredient.id)
            beer_ingredient.update(amount: ingredient_attribute[:amount])
          else
            self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
          end
        else
          ingredient = Ingredient.new(name: ingredient_attribute[:name], origin: ingredient_attribute[:origin], kind: ingredient_attribute[:kind])
          if ingredient.save
            new_beer_ingredient = self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
            old_ingredient = self.ingredients.find_by(kind: ingredient_attribute[:kind])
            if old_ingredient
              old_beer_ingredient = self.beer_ingredients.find_by(ingredient_id: old_ingredient.id)
              old_beer_ingredient.destroy
              new_beer_ingredient.save
            else
              new_beer_ingredient.save
            end
          end #TODO: how to raise the error
        end
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
