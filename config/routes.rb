Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  resources :admin, only: [:index]

  devise_for :users
  get 'home/index'

  root to: "home#index"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
