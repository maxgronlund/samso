class AddLatestOnlinePaymentDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :latest_online_payment, :datetime
  end
end
