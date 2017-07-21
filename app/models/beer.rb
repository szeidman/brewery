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

  #validate that all types of ingredients included

  scope :darkest, -> { where(kind: 'water') }
  #maximum("srm")

  #def beer_ingredient_attributes=(beer_ingredient_attributes)
  #  ingredient = Ingredient.find_or_create_by(name: attributes.name)
  #  IngredientAttribute.create(beer_id: self.id, ingredient_id: ingredient.id, amount: attributes.amount)
  #  self.beer_ingredients.build << ingredient
  #end

  #def ingredient_attributes=(attributes)

  #def add_ingredient(ingredient_id)
  #  beer_ingredient = self.beer_ingredient.find_by(ingredient_id: ingredient_id)
  #    if beer_ingredient
  #      beer_ingredient.update(params:[])
  #  if beer_ingredient
  #def ingredient_attributes
  #  self.ingredients.collect {|ingredient| ingredient.name}
  #end

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.each do |ingredient_attribute|
      ingredient = Ingredient.find_by(name: ingredient_attribute[:name])
        if ingredient
          if self.beer_ingredients.find_by(ingredient_id: ingredient.id)
            self.beer_ingredients.update(amount: ingredient_attribute[:amount])
          else
            self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
          end
        else
          ingredient = Ingredient.new(name: ingredient_attribute[:name], origin: ingredient_attribute[:origin], kind: ingredient_attribute[:kind])
          if ingredient.save
            self.beer_ingredients.build(ingredient_id: ingredient.id, amount: ingredient_attribute[:amount])
          end #TODO: how to raise the error
        end
    end
  end

  def find_ingredient(ingredient_id)
    self.beer_ingredients.find_by(ingredient_id: ingredient_id)
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
