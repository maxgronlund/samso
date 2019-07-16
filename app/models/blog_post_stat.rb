class BlogPostStat < ApplicationRecord
  belongs_to :admin_blog_post, class_name: 'Admin::BlogPost'
  has_many :weekly_views, dependent: :destroy

  def shown!
    return if updated_at > DateTime.now - 0.5.seconds
    weekly_views.create
    update_attributes(views: views + 1)
  rescue => e
    metadate =
      { blog_post_id: id, title: title }
      .merge(
        message: e.message,
        backtrace: e.backtrace
      )

    Admin::EventNotification.create(
      title: 'ERROR! BlogPostStat',
      body: 'Unable to update views',
      message_type: 'blot_post_stat',
      metadata: metadate
    )
  end

  def commented!(comment_id)
    weekly_comments.create
  end

  def views_last_seven_days
    weekly_views_count
  end

  def comments_last_seven_days
    weekly_comments_count
  end

  # usage
  # BlogPostStat.post_with_most_views_last_seven_days
  def self.post_with_most_views_last_seven_days(posts_count = 8)
    blog_post_ids =
      BlogPostStat
      .where.not(weekly_views_count: 0)
      .order(weekly_views_count: :desc)
      .first(posts_count)
      .pluck(:admin_blog_post_id)
    blog_post_ids.map { |blog_post_id| Admin::BlogPost.find(blog_post_id) }
  end

  def self.destroy_old_weekly_views!
    WeeklyView
      .where(find_condition, time_range)
      .destroy_all
  end

  def self.find_condition
    'created_at <= :one_week_ago'
  end

  def self.time_range
    { one_week_ago: Time.zone.now - 1.week }
  end
end
