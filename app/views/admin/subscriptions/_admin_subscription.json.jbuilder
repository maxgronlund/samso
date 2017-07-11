json.extract! admin_subscription, :id, :subscription_type_id, :duration, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url admin_subscription_url(admin_subscription, format: :json)
