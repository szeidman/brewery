class BeersController < ApplicationController
  def index
    @beers = Beer.all
  end

  def new
  end

  def edit
  end

  def show
  end
end
