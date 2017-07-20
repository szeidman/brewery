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
