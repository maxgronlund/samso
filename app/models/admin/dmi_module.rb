class Admin::DmiModule < ApplicationRecord
  attr_accessor :position
  attr_accessor :slot_id

  def admin_page
    page_module.page
  end

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::DmiModule',
      moduleable_id: id
    )
  end

  def page
    page_module.page
  end

  def position
    page_module.position
  end

  def slot_id
    page_module.slot_id
  end

  def self.forecasts
    [
      [I18n.t('dmi_module.days_two_forecast'), 'days_two_forecast'],
      [I18n.t('dmi_module.days_three_forecast'), 'days_three_forecast'],
      [I18n.t('dmi_module.days10to15forecast'), 'days10to15forecast']
    ]
  end
end
