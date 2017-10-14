# link for the vertiacal menu content
class CreateAdminMenuLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_menu_links do |t|
      t.string :title, default: ''
      t.integer :page_id
      t.string :url, default: ''
      t.boolean :active, default: true
      t.string :color, default: '#000'
      t.string :background_color, default: '#FFF'
      t.integer :menu_content_id

      t.timestamps
    end
    add_index :admin_menu_links, :menu_content_id
  end
end
