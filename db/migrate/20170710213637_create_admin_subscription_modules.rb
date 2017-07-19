# module for selecting subscriptions
class CreateAdminSubscriptionModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_subscription_modules do |t|
      t.string :name
      t.text :body
      t.string :layout

      t.timestamps
    end
  end
end
