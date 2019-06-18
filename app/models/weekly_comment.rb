class WeeklyComment < ApplicationRecord
  belongs_to :comment, counter_cache: true

  def self.articles(count = 9)
    blog_post_ids =
      Comment
      .where(commentable_type: 'Admin::BlogPost')
      .where.not(weekly_comments_count: 0)
      .order(weekly_comments_count: :desc)
      .first(count)
      .pluck(:commentable_id)

    blog_post_ids.map { |blog_post_id| Admin::BlogPost.find(blog_post_id) }
  end

  def self.destroy_old_weekly_comments!
    WeeklyComment
      .where(find_condition, time_range)
      .destroy_all
  end

  def self.find_condition
    'created_at <= :one_week_ago'
  end

  def self.time_range
    {one_week_ago: Time.zone.now - 1.week}
  end

end
