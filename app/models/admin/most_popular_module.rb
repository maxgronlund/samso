# show weather from DMI
class Admin::MostPopularModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::MostPopularModule',
      moduleable_id: id
    )
  end
end
