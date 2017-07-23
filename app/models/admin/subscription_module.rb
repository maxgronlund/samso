# module for selection subscription
class Admin::SubscriptionModule < ApplicationRecord
  include SectionPlugin

  def page_module
    @page_module ||= PageModule.find_by(
      moduleable_type: 'Admin::SubscriptionModule',
      moduleable_id: id
    )
  end
end
