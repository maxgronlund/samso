class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :full_name
      t.string :address
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end

    add_column :admin_subscriptions, :payment_id, :integer
    add_index :admin_subscriptions, :payment_id
  end
end
