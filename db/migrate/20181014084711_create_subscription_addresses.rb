class CreateSubscriptionAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_addresses do |t|
      t.belongs_to :admin_subscription, foreign_key: true
      t.belongs_to :address, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
