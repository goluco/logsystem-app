Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'
  resources :carriers do
    patch :deactivate, on: :member
    patch :activate, on: :member
  end
  resources :vehicles, only: [:new, :create]
  resources :prices do
    collection do
      get 'search'
    end
  end
  resources :volumes, only: [:new, :create]
  resources :weights, only: [:new, :create]
  resources :deadlines
  resources :budgets, only: [:new, :create, :index, :show]
  resources :orders do
    patch :accept, on: :member
    patch :refuse, on: :member
    patch :finalize, on: :member
    collection do
      get 'search'
    end
  end
  resources :infologs
end
