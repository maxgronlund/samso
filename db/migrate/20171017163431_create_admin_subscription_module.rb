# frozen_string_literal: true

# subscription
class CreateAdminSubscriptionModule < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_subscription_modules do |t|
      t.string :title
      t.text :body
      t.string :layout
      t.string :expired_title
      t.text :expired_body

      t.timestamps
    end
    add_module_name
  end

  def down
    drop_table :admin_subscription_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::SubscriptionModule', locale: 'admin/subscription_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::SubscriptionModule')
    module_name.delete if module_name.present?
  end
end
