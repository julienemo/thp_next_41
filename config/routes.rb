Rails.application.routes.draw do
  resources :images
  devise_for :users
  root to: 'images#index'

  get "/profile" => "static#profile"

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
