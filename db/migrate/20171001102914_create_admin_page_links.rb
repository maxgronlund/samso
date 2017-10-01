class CreateAdminPageLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_page_links do |t|
      t.string :name
      t.integer :position, default: 0
      t.string :page_id
      t.string :background_color, default: 'none'
      t.string :color, default: '#000'
      t.integer :page_link_module_id

      t.timestamps
    end
    add_index :admin_page_links, :page_id
    add_index :admin_page_links, :page_link_module_id
  end
end
