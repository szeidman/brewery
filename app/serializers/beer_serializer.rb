class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :style, :abv, :ibu, :srm
  has_many :ingredients, through: :beer_ingredients
  has_many :beer_ingredients
  belongs_to :user
end
