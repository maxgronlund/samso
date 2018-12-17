# frozen_string_literal: true

# Generic page
class CreatePages < ActiveRecord::Migration[5.1]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def change
    create_table :pages do |t|
      t.string :title
      t.string :menu_title
      t.string :menu_id, default: 'not_in_any_menus'
      t.integer :menu_position, default: 0
      t.boolean :active
      t.string :locale
      t.string :body_background_file_name
      t.string :body_background_content_type
      t.integer :body_background_file_size
      t.datetime :body_background_updated_at
      t.integer :page_rows_count, default: 0
      t.string :background_color, default: 'none'
      t.belongs_to :admin_footer, foreign_key: true
      t.boolean :cache_page, default: false

      t.timestamps
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
