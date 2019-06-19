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

  def self.comments_last_seven_days(blog_post_id)
    comment_ids =
      Comment
      .where(commentable_type: 'Admin::BlogPost', commentable_id: blog_post_id)
      .pluck(:id)
      .uniq

    WeeklyComment.where(comment_id: comment_ids).count

  end
end
