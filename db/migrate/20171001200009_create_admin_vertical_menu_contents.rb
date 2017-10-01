class CreateAdminVerticalMenuContents < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_vertical_menu_contents do |t|
      t.string :name

      t.timestamps
    end
  end
end
