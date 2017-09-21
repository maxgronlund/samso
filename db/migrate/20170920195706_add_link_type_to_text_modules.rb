# update text_modules properties
class AddLinkTypeToTextModules < ActiveRecord::Migration[5.1]
  def up
    add_column :text_modules, :link_layout, :string, default: 'text'
    add_column :text_modules, :image_ratio, :string, default: '2_1'
    remove_column :text_modules, :image_size
  end

  def down
    remove_column :text_modules, :link_layout
    remove_column :text_modules, :image_ratio
    add_column :text_modules, :image_size, :string, default: 'original'
  end
end
