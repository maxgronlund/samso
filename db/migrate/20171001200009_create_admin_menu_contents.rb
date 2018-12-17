# frozen_string_literal: true

# Shared content between vertical menu modules
class CreateAdminMenuContents < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_menu_contents do |t|
      t.string :name

      t.timestamps
    end
  end
end
