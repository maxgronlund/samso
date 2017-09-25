# dynamic blog to add on a page
class Admin::BlogModule < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  scope :ordered, -> { order('start_date DESC') }

  # find names here: https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/da.yml
  def self.layouts
    [
      [I18n.t('blog_module.the_beatles'), 'the_beatles'],
      [I18n.t('blog_module.elvis_presley'), 'elvis_presley']
    ]
  end

  # def posts_page
  #   page = Page.find_by(id: post_page_id)
  #   return page if page
  #   return admin_system_setup.post_page if admin_system_setup.post_page
  #   nil
  # end

  def paginated_posts(start = 0, finish = 100)
    posts
      .offset(start)
      .order('start_date DESC')
      .last(finish - start)
  end

  def show_on_page
    Page.find_by(id: post_page_id)
  end

  private

  # def admin_system_setup
  #   Admin::SystemSetup.find_by(locale: I18n.locale)
  # end
end
