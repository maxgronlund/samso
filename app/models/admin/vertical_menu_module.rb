# show weather from DMI
class Admin::VerticalMenuModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  belongs_to :vertical_menu_content, class_name: 'Admin::VerticalMenuContent', optional: true
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::VerticalMenuModule',
      moduleable_id: id
    )
  end
end
