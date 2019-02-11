Rails.application.routes.draw do


  resources :letter_to_the_editors, only: [:index]
  resources :comments
  namespace :api do
    namespace :v1 do
      resources :epaper_verification, only: %i[index show]
    end
  end

  scope "(:locale)", locale: /da|en/ do
    resources :search, only: %i[index show]
    resources :accepted_payments
    resources :advertisements
    resources :cancel_account, only: %i[show destroy]
    resources :declined_payments
    namespace :admin do
      resources :active_subscribers
      resources :advertisements
      resources :articles, only: %i[index]
      resources :blogs do
        resources :blog_posts
      end
      resources :blog_modules, only: %i[edit update]
      resources :calendars do
        resources :calendar_events
      end
      resources :calendar_modules, only: %i[edit update show]
      resources :carousel_modules, only: %i[edit update show] do
        resources :carousel_slides
      end
      resources :click_on_advertisements, only: %i[update]
      resources :csv_imports do
        resources :parse_csv, only: %i[new]
      end
      resources :dmi_modules, only: %i[edit update]

      resources :e_page_modules, only: %i[edit update]
      resources :featured_post_modules, only: %i[edit update]
      resources :find_blog_post_modules, only: %i[edit update]
      resources :search_result_modules, only: %i[edit update]
      resources :most_popular_modules, only: %i[edit update]
      resources :footers
      resources :gallery_images, only: %i[edit update]
      resources :gallery_modules, only: %i[edit update]
      resources :image_modules, only: %i[edit update]
      resources :latest_online_payments, only: %i[index]
      resources :menu_contents do
        resources :menu_links
      end
      resources :menu_modules
      resources :mega_menu_modules
      resources :pages do
        resources :page_rows
      end
      resources :page_link_modules, only: %i[edit update] do
        resources :page_links
      end

      resources :page_rows do
        resources :page_cols
      end
      resources :page_cols, only: [] do
        resources :page_col_modules
      end

      resources :post_modules, only: %i[edit update]
      resources :printed_ads
      resources :e_page_modules, only: %i[edit update]
      # resources :subscription_addresses, only: %i[show]
      # resources :subscriptions do
      #   resources :addresses, only: %i[new edit update destroy]
      # end
      resources :sign_in_ips, only: %i[index]
      resources :show_subscription_ids, only: %i[show]
      resources :subscriptions do
        resources :delivery_addresses
      end
      resources :subscription_modules, only: %i[edit update]
      resources :subscription_types
      resources :system_messages, only: %i[index edit update]
      resources :system_setups, only: %i[edit update]
      resources :text_modules
      resources :youtube_modules, only: %i[edit update]
      resources :read_also_modules, only: %i[edit update]
      resources :advertisement_modules, only: %i[edit update]
      resources :users do
        resources :user_subscriptions
        resources :invoices, only: %i[index show destroy]
      end
    end


    resources :print_posts, only: %i[show]

    namespace :service_functions do
      resources :printed_ads
    end

    resources :admin, only: %i[index]
    resources :gallery_images, only: %i[show]
    resources :gdpr, only: %i[show update]
    resources :blogs, only: [:show] do
      resources :posts
    end

    resources :pages do
      resources :posts, only: %i[show]
    end
    # resources :blogs, only: [:show]
    # resources :blog_posts, only: %i[show edit update destroy]

    resources :confirm_signups, only: %i[show index]
    resources :gallery_modules, only: [] do
      resources :gallery_images
    end
    resources :reset_password, except: %i[destroy]
    resources :pages, only: %i[show]

    resources :sessions, only: %i[new destroy create index]

    resources :subscriptions do
      resources :delivery_addresses
    end
    get '/:locale' => 'home#index'
    root to: "home#index"
    resources :users, except: %i[index] do
      resources :payments
      resources :invoices, only: %i[index show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
