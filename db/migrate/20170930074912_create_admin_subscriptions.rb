# TODO: Rename to UserSubscription
# a user subscription
class CreateAdminSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_subscriptions do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :subscription_type_id
      t.string :duration
      t.date :start_date
      t.date :end_date
      t.datetime :on_hold_date
      # legacy subscription support
      t.integer :subscription_id

      t.timestamps
    end
    add_index :admin_subscriptions, :subscription_type_id
  end
end
