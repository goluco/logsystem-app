Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :carriers
  resources :vehicles, only: [:new, :create]
end
