# Add image and teaser to text_module
class AddImageAndTeaserToTextModules < ActiveRecord::Migration[5.1]
  def up
    add_column :text_modules, :layout, :string
    add_column :text_modules, :url, :string
    add_column :text_modules, :url_text, :string
    add_attachment :text_modules, :image
    add_column :text_modules, :image_size, :string
  end

  def down
    remove_column :text_modules, :image_size
    remove_attachment :text_modules, :image
    remove_column :text_modules, :url
    remove_column :text_modules, :url_text
    remove_column :text_modules, :layout
  end
end
