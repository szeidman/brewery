class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def index
    @beers = Beer.all
  end

  def new
  end

  def edit
  end

  def update
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
      params.require(:beer).permit(:name, :style, :abv, :ibu, :srm, :user_id, ingredients_attributes:[:name, :kind, :origin])
    end

  end
