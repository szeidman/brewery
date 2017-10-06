class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :kind, :origin
  has_many :beers
  has_many :beer_ingredients
end
