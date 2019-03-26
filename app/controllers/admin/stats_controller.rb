class Admin::StatsController < AdminController

  # GET /admin/stats
  def index
    @users = User.count
    @last_weeks_new_users = User.where('created_at >= :a_week_ago', a_week_ago).count
    @times_signed_in = signed_in_users.sum(:sign_in_count)
    @users_signed_in = signed_in_users.count
    @total_posts_views = Admin::BlogPost.sum(:views)
    @last_week_posts_views = Admin::BlogPost .where('updated_at >= :a_week_ago', a_week_ago).count
    @comments = Comment.count
    @last_weeks_comments =
      Comment
      .where('created_at >= :a_week_ago', a_week_ago)
      .count
    @users_with_comments = User.where.not(comments_count: 0).count
    @subscriptions_count = Admin::Subscription.count
    @valid_subscriptions_count = Admin::Subscription.valid.count
  end

  private

  # users that have signed in at least one time
  def signed_in_users
    @signed_in_users ||= User.where.not(sign_in_count: 0)
  end

  def a_week_ago
    @a_week_ago ||= { a_week_ago: Time.zone.now - 1.week }
  end
end
