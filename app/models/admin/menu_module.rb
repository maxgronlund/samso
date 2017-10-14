# show weather from DMI
class Admin::MenuModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  belongs_to :menu_content, class_name: 'Admin::MenuContent', optional: true
  include PageColConcerns

  LAYOUTS =
    [
      [I18n.t('admin/menu_module.layouts.horizontal'), 'horizontal'],
      [I18n.t('admin/menu_module.layouts.vertical'), 'vertical']
    ].freeze

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::MenuModule',
      moduleable_id: id
    )
  end
end
