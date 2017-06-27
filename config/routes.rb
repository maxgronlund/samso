Rails.application.routes.draw do

  namespace :admin do
    resources :system_setups
  end
  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :users
    end

    resources :admin, only: [:index]

    devise_for :users

    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
