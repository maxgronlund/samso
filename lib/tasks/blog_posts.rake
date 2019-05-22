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

  # rake blog_posts:create_blog_post_stats
  desc 'update stats'
  task create_blog_post_stats: :environment do
    BlogPostStat.destroy_all
    Admin::BlogPost.find_each do |blog_post|
      blog_post_stat = BlogPostStat.where(
        admin_blog_post_id: blog_post.id
      ).first_or_initialize(
        admin_blog_post_id: blog_post.id
      )
      blog_post_stat.views = blog_post.obsolete_views
      blog_post_stat.start_date = blog_post.start_date
      blog_post_stat.save
    end
  end

  # rake blog_posts:delete_dublets
  desc 'remove dublets'
  task delete_dublets: :environment do
    count = 0
    last_post = nil
    Admin::BlogPost.find_each do |this_post|
      if dublet_post(last_post, this_post)
        this_post.destroy
        count += 1
        next
      end
      last_post = this_post
    end

    ap '====================='
    ap "#{count} dublets deleted"
    ap '====================='
  end

  def dublet_post(last_post, this_post)
    (last_post.teaser == this_post.teaser) && (last_post.body == this_post.body) && (last_post.title == this_post.title)
  end
end
