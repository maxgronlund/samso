Rails.application.routes.draw do
  scope "(:locale)", locale: /da|en/ do
    namespace :admin do
      resources :carousel_modules, only: %i[edit update show] do
        resources :carousel_slides
      end
      resources :csv_imports do
        resources :parse_csv, only: %i[new]
      end
      resources :blog_modules, only: %i[edit update] do
        resources :blog_posts, only: %i[edit update new create]
      end
      resources :dmi_modules, only: %i[edit update]

      resources :footers
      resources :gallery_images, only: %i[edit update]
      resources :gallery_modules, only: %i[edit update]
      resources :image_modules, only: %i[edit update]
      resources :pages do
        resources :page_rows
      end
      resources :page_rows do
        resources :page_cols
      end
      resources :page_cols, only: [] do
        resources :page_col_modules
      end
      resources :post_modules, only: %i[edit update]
      resources :subscriptions
      resources :subscription_modules, only: %i[edit update]
      resources :subscription_types
      resources :system_messages, only: %i[index edit update]
      resources :system_setups, only: %i[edit update]
      resources :text_modules
      resources :users
    end

    resources :admin, only: %i[index]
    resources :gallery_images, only: %i[show]
    resources :blogs, only: [] do
      resources :posts
    end
    # resources :blogs, only: [:show]
    # resources :blog_posts, only: %i[show edit update destroy]

    resources :confirm_signups, only: %i[show index]
    resources :gallery_modules, only: [] do
      resources :gallery_images
    end
    
    resources :reset_password, except: %i[destroy]
    resources :pages, only: %i[show]
    resources :payments
    resources :sessions, only: %i[new destroy create index]
    resources :subscriptions
    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users, except: %i[index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
