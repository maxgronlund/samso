class Admin::ExportDeliveryListController < AdminController
  require 'csv'
  def index
    @subscriptions =
      Admin::Subscription
      .valid
      .order(:subscription_id)
      .joins(:user)
      .joins(:subscription_type)
      .where(admin_subscription_types: { print_version: true })

    respond_to do |format|
      format.html
      format.csv { send_data @subscriptions.to_csv, filename: "DAO-Hovedliste-#{Date.today}.csv" }
    end
  end
end
