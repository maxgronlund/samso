# Support for subscription types
class CreateAdminSubscriptionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_subscription_types do |t|
      t.string :title
      t.text :body
      t.boolean :internet_version
      t.boolean :print_version
      t.decimal :price
      t.string :locale
      t.boolean :active
      t.integer :duration
      t.integer :position, default: 0
      t.integer :subscriptions_count

      t.timestamps
    end
  end
end
