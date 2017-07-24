class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :destroy]

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

  def malt
    @ingredients = Ingredient.malt
  end

  def yeast
    @ingredients = Ingredient.yeast
  end

  def hops
    @ingredients = Ingredient.hops
  end

  def water
    @ingredients = Ingredient.water
  end

  def new
    has_beer
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to @ingredient
    else
      render :new
    end
  end

  def edit
    has_beer
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient, notice: 'Ingredient updated.'
    else
      render :edit
    end
  end

  def show
    if has_beer
      if @ingredient = @beer.ingredients.find_by(id: params[:id])
        @ingredient
        @amount = @beer.beer_ingredients.find_by(ingredient_id: params[:id]).amount
      else
        redirect_to beer_ingredients_path(@beer), alert: "Ingredient not found."
      end
    else
      set_ingredient
    end
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name, :kind, :origin)
    end

    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def has_beer
      @beer = Beer.find_by(id: params[:beer_id])
    end

end
