# frozen_string_literal: true

# show weather from DMI
class Admin::DmiModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::DmiModule',
      moduleable_id: id
    )
  end

  def self.forecasts
    [
      [I18n.t('dmi_module.days_two_forecast'), 'days_two_forecast'],
      [I18n.t('dmi_module.days_three_forecast'), 'days_three_forecast'],
      [I18n.t('dmi_module.days10to15forecast'), 'days10to15forecast']
    ]
  end
end
