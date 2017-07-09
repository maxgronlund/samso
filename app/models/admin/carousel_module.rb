# Module for carousel
class Admin::CarouselModule < ApplicationRecord
  has_many :slides, class_name: 'Admin::CarouselSlide', dependent: :destroy

  def admin_page
    page_module.page
  end

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::CarouselModule',
      moduleable_id: id
    )
  end

  def page
    page_module.page
  end

  def self.image_sizes
    [
      [I18n.t('big'), '12_col_4x1'],
      [I18n.t('medium'), '9_coll_3x1'],
      [I18n.t('small'), '6_coll_2x1']
    ]
  end
end
