class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :pages, :menu_title
    add_index :pages, :locale
    add_index :pages, :title

    # add_index :users, :email
    add_index :users, :signature
    add_index :users, :user_id
    add_index :users, :auth_token
    add_index :users, :uuid
    add_index :users, :confirmation_token


    add_index :roles, :permission

    add_index :admin_blogs, :index_page_id
    add_index :admin_blogs, :title

    add_index :admin_subscriptions, :subscription_id
    add_index :admin_subscription_types, :identifier
    add_index :admin_system_setups, :locale
    add_index :admin_system_setups, [:locale, :id]
    add_index :admin_module_names, :name

    add_index :payments, :onpay_reference
    add_index :payments, :uuid

    add_index :e_paper_tokens, :secret

    add_index :page_col_modules, :moduleable_type
    add_index :page_cols, :layout

    add_index :addresses, :address_type





    add_index :page_cols, :index
  end
end
