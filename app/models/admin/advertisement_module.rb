# frozen_string_literal: true

# show weather from DMI
class Admin::AdvertisementModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::AdvertisementModule',
      moduleable_id: id
    )
  end

  def advertisements
    admin_advertisements = Admin::Advertisement.active.where(locale: I18n.locale)
    admin_advertisements.map(&:viewed!)
    admin_advertisements
  end
end
