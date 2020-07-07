class CreateAccountController < ApplicationController
  def index
    @subscription_page = Page.find(admin_system_setup.subscription_page_id)
  rescue => e
    nil
  end
end
