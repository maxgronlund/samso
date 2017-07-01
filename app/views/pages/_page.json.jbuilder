json.extract! page, :id, :title, :menu_title, :position, :active, :locale, :user_id, :created_at, :updated_at
json.url page_url(page, format: :json)
