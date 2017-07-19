# Subscriptions assigned to users
class CreateAdminSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_subscriptions do |t|
      t.integer :subscription_type_id
      t.string :duration
      t.date :start_date
      t.date :end_date
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :admin_subscriptions, :subscription_type_id
  end
end
