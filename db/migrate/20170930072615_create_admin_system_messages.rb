# frozen_string_literal: true

# translated system messages
class CreateAdminSystemMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_system_messages do |t|
      t.string :title
      t.text :body
      t.string :identifier
      t.string :locale

      t.timestamps
    end
  end
end
