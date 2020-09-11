# frozen_string_literal: true

# generic text module
class CreateAdminTextModules < ActiveRecord::Migration[6.0]
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def up
    create_table :admin_text_modules do |t|
      t.string :title, default: ''
      t.text :body, default: ''
      t.string :url
      t.string :url_text
      t.integer :page_id
      t.string :color, default: '#000000'
      t.string :background_color, default: '#FFFFFF'
      t.boolean :border, default: false
      t.string :image_style, default: 'full-width'
      t.string :link_layout, default: 'text'
      t.string :image_ratio, default: '2_1'
      t.belongs_to :user

      t.timestamps
    end
    add_index :admin_text_modules, :page_id
    add_attachment :admin_text_modules, :image
    add_module_name
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def down
    drop_table :admin_text_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::TextModule', locale: 'admin/text_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::TextModule')
    module_name.delete if module_name.present?
  end
end
