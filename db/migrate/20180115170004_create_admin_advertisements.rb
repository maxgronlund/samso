# frozen_string_literal: true

# Advretisements
class CreateAdminAdvertisements < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def change
    create_table :admin_advertisements do |t|
      t.string :title
      t.text :body
      t.decimal :price_pr_view, default: 0.0
      t.integer :views, default: 0
      t.decimal :price_pr_click, default: 0.0
      t.integer :clicks, default: 0
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active, default: true
      t.boolean :featured, default: false
      t.decimal :featured_price, default: 0.0
      t.decimal :price, default: 0.0
      t.string :url, default: ''
      t.string :locale
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
