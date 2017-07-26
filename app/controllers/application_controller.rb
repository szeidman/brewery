class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  helper_method :creator?

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
    super resource
  end

  def creator?
    if @beer && current_user
      current_user.id == @beer.user_id
    else
      false
    end
  end

end
