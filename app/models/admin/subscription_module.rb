class Admin::SubscriptionModule < ApplicationRecord

  attr_accessor :position

  def admin_page
    page_module.page
  end

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::SubscriptionModule',
      moduleable_id: id
    )
  end

  def position
    page_module.position
  end

end
