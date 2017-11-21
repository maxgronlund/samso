namespace :blog_posts do
  # usage
  # rake blog_posts:update_layout
  desc 'update the layout on blog_posts'
  task update_layout: :environment do
    pritify_layouts
  end

  def pritify_layouts
    Admin::BlogPostCategory.find_each do |blog_post_category|
      pritify_blog_posts(
        Admin::BlogPost.where(admin_blog_post_category_id: blog_post_category.id)
      )
    end
  end

  def pritify_blog_posts(blog_posts)
    count = 1
    blog_posts.find_each do |blog_post|
      layout = count.even? ? 'image_left' : 'image_right'
      blog_post.update_attributes(layout: layout)
      count += 1
    end
  end
end
