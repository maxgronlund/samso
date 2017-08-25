Rails.application.routes.draw do

  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :carousel_modules, only: [] do
        resources :carousel_slides
      end
      resources :csv_imports
      resources :footers
      resources :pages do
        resources :blog_modules, only: [:edit, :update] do
          resources :blog_posts, only: [:edit, :update, :new, :create]
        end
        resources :carousel_modules, only: [:edit, :update, :show]
        resources :dmi_modules, only: [:edit, :update]
        resources :gallery_modules, only: [:edit, :update]
        resources :image_modules, only: [:edit, :update]
        resources :post_modules, only: [:edit, :update]
        resources :page_modules, only: [:new, :create, :destroy]
        resources :subscription_modules, only: [:edit, :update]
        resources :text_modules, only: [:edit, :update]
      end
      resources :subscriptions
      resources :subscription_types
      resources :system_setups, only: [:edit, :update]
      resources :users
    end

    resources :admin, only: [:index]
    resources :blog, only: [] do
      resources :posts, only: [:new, :create]
    end
    resources :confirm_signups, only: %i[show index]
    resources :gallery_modules, only: [] do
      resources :gallery_images
    end
    resources :posts, only: %i[show edit update destroy]
    resources :reset_password, only: %i[index create]
    resources :pages, only: [:show]
    resources :payments
    resources :sessions, only: %i[new destroy create]
    resources :subscriptions
    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users, except: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
