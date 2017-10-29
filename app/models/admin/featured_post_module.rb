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

  def blog_module
    Admin::BlogModule.find_by(id: admin_blog_module_id)
  end

  def posts
    return [] if blog_module.nil?
    return [] if blog_module.featured_post.nil?
    blog_module.featured_post
  end
end
