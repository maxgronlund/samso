class WeeklyComment < ApplicationRecord
  belongs_to :comment

  def self.articles(count = 9)
    blog_post_ids =
      BlogPostStat
      .where.not(weekly_comments_count: 0)
      .order(weekly_comments_count: :desc)
      .first(count)
      .pluck(:admin_blog_post_id)

    blog_post_ids.map { |blog_post_id| Admin::BlogPost.find(blog_post_id) }
  end
end
