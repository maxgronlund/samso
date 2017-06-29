Rails.application.routes.draw do
  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :users
      resources :contents
      resources :system_setups, only: [:edit, :update]
    end

    resources :about, only: [:index]
    resources :admin, only: [:index]
    resources :maintenance, only: [:index]

    devise_for :users

    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users, except: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
