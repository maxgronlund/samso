json.extract! content, :id, :title, :body, :identifier, :position, :contentable_id, :contentable_type, :created_at, :updated_at
json.url content_url(content, format: :json)
