json.extract! payment, :id, :name, :email, :address, :postal_code_and_city, :password, :password_confirmation, :news_letter, :subscription_id, :user_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
