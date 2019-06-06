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

  def comments_last_seven_days(blog_post_id)
    BlogPostStat
      .find_by(admin_blog_post_id: blog_post_id)
      .comments_last_seven_days
  end
end
