module IngredientsHelper

  def error_field?(attribute)
    if @ingredient.errors[attribute.to_sym].count > 0
      "field_with_errors"
    else
      ""
    end
  end

  def amount_params
    if params[:ingredient]
      if params[:ingredient][:beer]
        params[:ingredient][:beer][:ingredient_attributes][0][:amount]
      end
    end
  end

  def kind_params
    if params[:ingredient]
      if params[:ingredient][:beer]
        params[:ingredient][:beer][:ingredient_attributes][0][:kind]
      end
    end
  end

  def name_params
    if params[:ingredient]
      if params[:ingredient][:beer]
        params[:ingredient][:beer][:ingredient_attributes][0][:name]
      end
    end
  end

  def origin_params
    if params[:ingredient]
      params[:ingredient][:beer][:ingredient_attributes][0][:origin]
    end
  end

end
