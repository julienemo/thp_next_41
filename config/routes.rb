Rails.application.routes.draw do
  root to: 'images#index'
  get "/profile" => "static#profile"

  devise_for :users
  resources :users

  resources :images do
    resources :comments
  end
end
