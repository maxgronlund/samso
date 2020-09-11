# frozen_string_literal: true

class UpdateAdminAdverticements < ActiveRecord::Migration[6.0]
  def up
    add_column :admin_advertisements, :notes, :text, default: ''
    add_column :admin_advertisements, :user_id, :integer
    add_index :admin_advertisements, :user_id
  end

  def down
    remove_column :admin_advertisements, :notes
    remove_column :admin_advertisements, :user_id
  end
end
