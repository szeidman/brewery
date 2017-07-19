class Beer < ApplicationRecord
  belongs_to :user
  has_many :beer_ingredients
  has_many :ingredients, through: :beer_ingredients

  def color
    if self.srm < 3.0
      "Pale Yellow"
    else
      "Very Dark"
    end
  end

  def bitter
    if self.ibu > 50
      "Bitter!"
    else
      "Not terribly bitter."
    end
  end

  def alcohol
  end

end
