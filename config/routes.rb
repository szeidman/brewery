Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  resources :beers do
    resources :ingredients, only: [:show, :index, :new, :create]
  end
  get 'ingredients/hops', :to => 'ingredients#hops'
  get 'ingredients/yeast', :to => 'ingredients#yeast'
  get 'ingredients/malt', :to => 'ingredients#malt'
  get 'ingredients/water', :to => 'ingredients#water'
  resources :ingredients


end
