class CreateAccountController < ApplicationController
  def index
    @subscription_page = Page.find_by(id: admin_system_setup.subscription_page_id)

  end
end
