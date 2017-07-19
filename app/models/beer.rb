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
    if self.abv > 7
      "Lotsa booze"
    elsif self.abv > 5.5
      "More than a little."
    elsif self.abv > 4.5
      "Average."
    elsif self.abv > 3.5
      "Sessionable."
    else
      "Near beer."
    end
  end

end
