class BeerIngredientsController < ApplicationController

  def new
    @beer_ingredient = BeerIngredient.new
  end

  def create
    @beer_ingredient = BeerIngredient.new(beer_ingredient_params)
  end

  private
    def beer_ingredient_params
      params.require(:beer_ingredient).permit(:id, :beer_id, :ingredient_id, :amount)
    end

end
