# papertrail for payments, might be subject to changes
class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :postal_code_and_city
      t.string :password
      t.string :password_confirmation
      t.boolean :news_letter
      t.integer :subscription_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :payments, :subscription_id
  end
end
