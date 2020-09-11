json.extract! admin_blog_post_content, :id, :title, :body, :image, :image_caption, :position, :admin_blog_post_id, :created_at, :updated_at
json.url admin_blog_post_content_url(admin_blog_post_content, format: :json)
