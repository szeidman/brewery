class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def new
  end

  def edit
  end

  def show
  end
end
