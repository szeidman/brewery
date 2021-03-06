class BeerIngredientsController < ApplicationController

  def new
    @beer_ingredient = BeerIngredient.new
  end

  def create
    @beer_ingredient = BeerIngredient.new(beer_ingredient_params)
  end

  def destroy
    @beer_ingredient = BeerIngredient.find(params[:id])
  end

  private
    def beer_ingredient_params
      params.require(:beer_ingredient).permit(:beer_id, :ingredient_id, :amount)
    end

end
