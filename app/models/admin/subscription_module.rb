# module for selection subscription
class Admin::SubscriptionModule < ApplicationRecord
  attr_accessor :position

  def admin_page
    page_module.page
  end

  def page_module
    @page_module ||= PageModule.find_by(
      moduleable_type: 'Admin::SubscriptionModule',
      moduleable_id: id
    )
  end

  def position
    page_module ? page_module.position : 0
  end

  def page
    page_module ? page_module.page : nil
  end
end
