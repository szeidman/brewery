Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  resources :beers do
    resources :ingredients, only: [:show, :index, :new]
  end
  resources :ingredients
  resources :beer_ingredients, only: [:create]

end
