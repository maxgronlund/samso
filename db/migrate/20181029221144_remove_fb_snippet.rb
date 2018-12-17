# frozen_string_literal: true

class RemoveFbSnippet < ActiveRecord::Migration[5.2]
  def change
    remove_column :admin_system_setups, :fb_snippet, :text, default: ''
  end
end
