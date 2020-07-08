# show weather from DMI
class Admin::WeeklyCommentModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::WeeklyCommentModule',
      moduleable_id: id
    )
  end

  def articles_with_comments
    # blog_post_ids =
    #   Comment
    #   .where('created_at > :one_week_ago', one_week_ago: Time.zone.now - 1.week)
    #   .where.not(state: 'removed')
    #   .pluck(:admin_blog_post_id)
    #   .uniq
    #   .compact

    # Admin::BlogPost
    #   .where(id: blog_post_ids)
    #   .order(comments_count: :desc)
    #   .where.not(comments_count: 0)
    #   .last(articles)

    Admin::BlogPost
      .where.not(comments_count: 0)
      .where("start_date > :start_date", start_date: Time.zone.now - 1.week)
      .order('comments_count DESC').first(8)

  end
end
