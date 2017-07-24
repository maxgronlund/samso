# dynamic blog to add on a page
class Admin::BlogModule < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy
  include SectionPlugin

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::BlogModule',
      moduleable_id: id
    )
  end

  # find names here: https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/da.yml
  def self.layouts
    [
      [I18n.t('blog_module.the_beatles'), 'the_beatles'],
      [I18n.t('blog_module.elvis_presley'), 'elvis_presley']
    ]
  end
end
