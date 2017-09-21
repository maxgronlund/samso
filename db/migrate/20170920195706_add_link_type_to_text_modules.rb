class AddLinkTypeToTextModules < ActiveRecord::Migration[5.1]
  def change
    add_column :text_modules, :link_layout, :string, default: 'text'
  end
end
