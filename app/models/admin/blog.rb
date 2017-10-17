# a blog to embed inside the BlogModule
class Admin::Blog < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy

  def clear_cache_on_pages
    blog_modules = Admin::BlogModule.where(admin_blog_id: id)
    blog_modules.each(&:clear_page_cache)
  end
end
