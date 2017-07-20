class BeerIngredientsController < ApplicationController

  def new
    @beer_ingredient = BeerIngredient.new
  end

  def create
    @beer_ingredient = BeerIngredient.new(beer_ingredient_params)
  end

  private
    def beer_ingredient_params
      params.require(:beer_ingredient).permit(:beer_id, :amount, ingredient_attributes:[:id, :name, :kind, :origin])
    end

end
