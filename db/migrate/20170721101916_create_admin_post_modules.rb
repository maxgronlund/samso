class CreateAdminPostModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_post_modules do |t|
      t.string :name

      t.timestamps
    end
  end
end
