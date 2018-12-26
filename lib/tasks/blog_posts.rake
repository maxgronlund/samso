namespace :blog_posts do
  # usage
  # rake blog_posts:update_layout
  desc 'update the layout on blog_posts'
  task update_layout: :environment do
    pritify_layouts
  end

  def pritify_layouts
    Admin::Blog.find_each do |blog|
      pritify_blog_posts(
        blog.posts
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

  # rake blog_posts:delete_dublets
  desc 'remove dublets'
  task delete_dublets: :environment do
    last_post = Admin::BlogPost.first
    Admin::BlogPost.find_each do |this_post|
      next if this_post == Admin::BlogPost.first
      this_post.destroy if dublet_post(last_post, this_post)
      last_post = this_post
    end
  end

  def dublet_post(last_post, this_post)
    return false unless last_post.teaser == this_post.teaser
    return false unless last_post.body == this_post.body
    return false unless last_post.title == this_post.title
    true
  end
end
