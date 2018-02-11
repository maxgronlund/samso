# for imported paper subscriptions
class AddAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :address, :string
    add_column :users, :postal_code_and_city, :string
    add_column :users, :legacy_subscription_id, :string
  end
end
