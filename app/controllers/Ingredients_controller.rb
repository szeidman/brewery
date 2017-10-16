class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :destroy]
  helper_method :creator_user_only?

  def index
    if params[:beer_id]
       @beer = Beer.find(params[:beer_id])
       if @beer
         @ingredients = @beer.ingredients
         respond_to do |format|
           format.html { render :index }
           format.json { render json: @ingredients, each_serializer: SimpleIngredientSerializer }
         end
       else
         redirect_to beers_path, alert: "Beer not found."
       end
     else
       @ingredients = Ingredient.all
       respond_to do |format|
         format.html { render :index }
         format.json { render json: @ingredients, each_serializer: SimpleIngredientSerializer }
       end
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
    if has_beer
      if creator?
        @ingredient = @beer.ingredients.build
      else
        redirect_to @beer, notice: "Only the brewer who created the beer can perform this action."
      end
    else
      @ingredient = Ingredient.new
    end
  end

  def create
    if has_beer
      @ingredient = @beer.ingredients.build(name: params[:ingredient][:beer][:ingredient_attributes][0][:name], origin: params[:ingredient][:beer][:ingredient_attributes][0][:origin], kind: params[:ingredient][:beer][:ingredient_attributes][0][:kind])
      @ingredient.beer_ingredients.build(beer_id: @beer.id, amount: params[:ingredient][:beer][:ingredient_attributes][0][:amount])
      if @ingredient.valid?
        old_ingredient = @beer.ingredients.find_by(kind: params[:ingredient][:beer][:ingredient_attributes][0][:kind])
        if old_ingredient
          old_beer_ingredient = @beer.beer_ingredients.find_by(ingredient_id: old_ingredient.id)
          old_beer_ingredient.delete
          if @ingredient.save
            @ingredient.save
            respond_to do |f|
              f.html {redirect_to beer_ingredients_path(@beer), notice: "New beer ingredient added."}
              f.json {render json: @ingredient}
            end
          else
            respond_to do |f|
              f.html {render :new}
              f.json {render json: {error_messages: @ingredient.errors.full_messages, error_type: @ingredient.errors}}
            end
          end
        else
          if @ingredient.save
            @ingredient.save
            respond_to do |f|
              f.html {redirect_to beer_ingredients_path(@beer), notice: "New beer ingredient added."}
              f.json {render json: @ingredient}
            end
          else
            respond_to do |f|
              f.html {render :new}
              f.json {render json: {error_messages: @ingredient.errors.full_messages, error_type: @ingredient.errors}}
            end
          end
        end
      else
        respond_to do |f|
          f.html {render :new}
          f.json {render json: {error_messages: @ingredient.errors.full_messages, error_type: @ingredient.errors}}
        end
      end
    else
      @ingredient = Ingredient.new(ingredient_params)
      if @ingredient.save
        respond_to do |f|
          f.html {redirect_to @ingredient}
          f.json {render json: @ingredient}
        end
      else
        respond_to do |f|
          f.html {render :new}
          f.json {render json: {error_messages: @ingredient.errors.full_messages, error_type: @ingredient.errors}}
        end
      end
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
        @amount = @beer.beer_ingredients.find_by(ingredient_id: params[:id]).amount
        ingredients = @beer.ingredients
        sorted_ingredients = ingredients.sort{|a, b| a.name <=> b.name}
        @ingredient_ids = sorted_ingredients.collect{|ingredient| ingredient.id}
        respond_to do |format|
          format.html { render :show }
          format.json { render json: @ingredient }
        end
      else
        redirect_to beer_ingredients_path(@beer), alert: "Ingredient not found."
      end
    else
      set_ingredient
      ingredients = Ingredient.all
      @ingredient_ids = ingredients.collect{|ingredient| ingredient.id}
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @ingredient }
      end
    end
  end

  def destroy
    if @ingredient.beers.any?
      redirect_to @ingredient, notice: 'This ingredient cannot be deleted because beers need it!'
    else
      @ingredient.destroy
      redirect_to ingredients_path, notice: 'Ingredient was successfully deleted.'
    end
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name, :kind, :origin, beer_ids: [], beer: [:id, ingredient_attributes: [:name, :origin, :kind]])
    end

    def beer_params
      params.require(:beer).permit(:user_id, :name, :style, :abv, :ibu, :srm, ingredient_ids:[], ingredient_attributes: [:name, :origin, :kind, :amount])
    end

    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def has_beer
      if Beer.find_by(id: params[:beer_id])
        @beer = Beer.find_by(id: params[:beer_id])
      elsif params[:ingredient]
        if params[:ingredient][:beer]
          @beer = Beer.find_by(id: params[:ingredient][:beer][:id])
        end
      end
    end

end
