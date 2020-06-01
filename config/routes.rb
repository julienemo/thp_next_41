Rails.application.routes.draw do
  root to: 'images#index'
  
  get "/profile" => "static#profile"
  get "/profile/images" => "static#images"  
  get "/profile/comments" => "static#comments"

  devise_for :users
  resources :users

  resources :images do
    resources :comments
  end
end
