class BeerIngredientSerializer < ActiveModel::Serializer
  attributes :amount, :beer_id
  belongs_to :beer
  belongs_to :ingredient
end
