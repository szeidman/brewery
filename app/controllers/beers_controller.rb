class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def new
  end

  def edit
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def recipe
    @beer = Beer.find(params[:id])
  end
end
