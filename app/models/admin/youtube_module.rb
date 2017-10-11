# show weather from DMI
class Admin::YoutubeModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::YoutubeModule',
      moduleable_id: id
    )
  end
end
