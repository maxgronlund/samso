class AddGdprAcceptedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gdpr_accepted, :boolean, default: false
  end
end
