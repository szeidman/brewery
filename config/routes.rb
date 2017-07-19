Rails.application.routes.draw do
  get 'beers/new'

  get 'beers/edit'

  get 'beers/index'

  get 'beers/show'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  resources :beers

end
