# frozen_string_literal: true

# Payment mock
class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :address
      t.string :postal_code_and_city
      t.integer :subscription_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    add_index :payments, :subscription_id
  end
end
