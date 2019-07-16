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
    blog_post_ids =
      Comment
      .where('created_at <= :one_week_ago', one_week_ago: Time.zone.now - 1.week)
      .where.not(state: 'removed')
      .pluck(:admin_blog_post_id)

    Admin::BlogPost
      .where(id: blog_post_ids)
      .where.not(comments_count: 0)
      .last(articles)
    # comment_ids =
    #   Comment
    #   .where(commentable_type: 'Admin::BlogPost', commentable_id: blog_post_id)
    #   .pluck(:id)
    #   .uniq

    # WeeklyComment.where(comment_id: comment_ids).count
  end
end
