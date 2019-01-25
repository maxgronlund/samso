class AddUuidToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :uuid, :uuid
  end
end
