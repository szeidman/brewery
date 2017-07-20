class IngredientsController < ApplicationController
  def index
    if params[:beer_id]
       @beer = Beer.find(params[:beer_id])
       if @beer
         @ingredients = @beer.ingredients
       else
         redirect_to beers_path, alert: "Beer not found."
       end
     else
       @ingredients = Ingredient.all
     end
  end

  def new
  end

  def edit
  end

  def show
    if @beer = Beer.find_by(id: params[:beer_id])
      if @ingredient = @beer.ingredients.find_by(id: params[:id])
        @ingredient
      else
        redirect_to beer_ingredients_path(@beer), alert: "Ingredient not found."
      end
    else
      @ingredient = Ingredient.find(params[:id])
    end
  end

end
