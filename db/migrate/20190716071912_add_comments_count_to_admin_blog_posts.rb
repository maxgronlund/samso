class AddCommentsCountToAdminBlogPosts < ActiveRecord::Migration[5.2]
  def up
    add_column :admin_blog_posts, :comments_count, :integer, default: 0
    add_column :comments, :admin_blog_post_id, :integer
    add_index :comments, :admin_blog_post_id

    update
  end

  def down
    remove_column :admin_blog_posts, :comments_count
    remove_column :comments, :admin_blog_post_id
  end

  private

  def update
    Comment.find_each do |comment|
      comment.update(admin_blog_post_id: comment.commentable_id)
    end
    blog_post_ids =
      Comment
      .pluck(:admin_blog_post_id)
      .uniq
      .compact

    blog_post_ids.each do |id|
      blog_post = Admin::BlogPost.find(id)
      count = blog_post.comments.count
      next if count.zero?

      blog_post.update(comments_count: count)
    end
  end
end
