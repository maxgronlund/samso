Rails.application.routes.draw do
  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :users
    end

    resources :admin, only: [:index]
    resources :system_setups, only: [:edit, :update]
    devise_for :users

    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
