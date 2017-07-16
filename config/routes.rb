Rails.application.routes.draw do

  resources :payments
  #devise_for :users, controllers: { sessions: 'users/sessions' }

  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :pages do
        resources :page_modules, only: [:new, :create, :destroy]
        resources :text_modules, only: [:edit, :update]
        resources :carousel_modules, only: [:edit, :update, :show]
        resources :subscription_modules, only: [:edit, :update]
      end
      resources :carousel_modules, only: [] do
        resources :carousel_slides
      end
      resources :posts
      resource :subscriptions
      resources :subscription_types
      resources :system_setups, only: [:edit, :update]
      resources :users
    end
    resources :about, only: [:index]
    resources :admin, only: [:index]
    resources :maintenance, only: [:index]
    resources :pages, only: [:show]
    resources :subscriptions
    #resources :subscription_types
    #devise_for :users
    devise_for :users, controllers: { sessions: 'users/sessions' }
    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users, except: [:index]

    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
