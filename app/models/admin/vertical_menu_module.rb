# show weather from DMI
class Admin::VerticalMenuModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  has_one :vertical_menu_content, class_name: 'Admin::VerticalMenuContent'
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::VerticalMenuModule',
      moduleable_id: id
    )
  end
end
