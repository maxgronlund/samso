# frozen_string_literal: true

class AddGdprAcceptedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gdpr_accepted, :boolean, default: false
  end
end
