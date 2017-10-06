class BeerIngredientSerializer < ActiveModel::Serializer
  attributes :amount, :ingredient_id, :beer_id
  belongs_to :beer
  belongs_to :ingredient
end
