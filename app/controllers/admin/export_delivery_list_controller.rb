class Admin::ExportDeliveryListController < AdminController
  require 'csv'
  def index
    @subscriptions =
      Admin::Subscription
      .order(:subscription_id)
      .joins(:user)
      .joins(:subscription_type)
      .where(admin_subscription_types: { print_version: true })

      respond_to do |format|
        format.html
        format.csv { send_data @subscriptions.to_csv, filename: "users-#{Date.today}.csv" }
        #format.csv { render text: @subscriptions.to_csv }
      end
  end
end
