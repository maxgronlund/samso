# show weather from DMI
class Admin::IframeModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::IframeModule',
      moduleable_id: id
    )
  end
end
