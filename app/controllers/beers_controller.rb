class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def index
    @beers = Beer.all
  end

  def new
    @beer = Beer.new
    4.times do @beer.beer_ingredients.build
    end
  end

  def create
    @beer = Beer.new(beer_params)
    if @beer.save
      redirect_to @beer, notice: 'Beer created.'
    else
      render :new
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

  private

    def set_beer
      @beer = Beer.find(params[:id])
    end

    def beer_params
      params.require(:beer).permit(:user_id, :name, :style, :abv, :ibu, :srm, ingredient_ids:[], ingredient_attributes: [:name, :origin, :kind, :amount])
    end

  end
