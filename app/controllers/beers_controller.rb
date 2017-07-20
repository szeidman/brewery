class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def index
    @beers = Beer.all
  end

  def new
    @beer = Beer.new
    @beer.beer_ingredients.build
    @beer.beer_ingredients.each do |i|
      i.build_ingredient
    end
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      redirect_to @beer, notice: 'Beer created.'
    else
      render :new
      # errors alert
    end
  end

  def edit
  end

  def update
    if @beer.update(beer_params)
      redirect_to @beer, notice: 'Beer updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  def show
  end

  def recipe
    @beer = Beer.find(params[:id])
  end

  private

    def set_beer
      @beer = Beer.find(params[:id])
    end

    def beer_params
      params.require(:beer).permit(:name, :style, :abv, :ibu, :srm, :user_id, beer_ingredients_attributes: [:id, :amount, ingredient_attributes: [:id, :name, :kind, :origin]])
    end

  end
