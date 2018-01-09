# show weather from DMI
class Admin::FeaturedPostModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  # belongs_to :blog_module, class_name: 'Admin::BlogModule'
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::FeaturedPostModule',
      moduleable_id: id
    )
  end

  # def blog_module
    # Admin::BlogModule.find_by(id: admin_blog_module_id)
  # end

  def featured_posts
    Admin::BlogPost
      .order('start_date DESC')
      .where(featured: true)
      .where(
        'start_date <= :today', today: Date.today + 1.day
      )
      .first(featured_posts_pr_page)
  end
end
