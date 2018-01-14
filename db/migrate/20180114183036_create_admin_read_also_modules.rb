# Module for new feature
class CreateAdminReadAlsoModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_read_also_modules do |t|
      t.string :name
      t.integer :blog_id
      t.integer :posts_pr_page, default: 8
      t.boolean :show_all_categories, default: true

      t.timestamps
    end
    add_index :admin_read_also_modules, :blog_id
    Admin::ModuleName
      .where(name: 'Admin::ReadAlso')
      .first_or_create(
        name: 'Admin::ReadAlsoModule',
        locale: 'admin/read_also_module.name'
      )
  end

  def down
    drop_table :admin_read_also_modules

    Admin::ModuleName
      .where(name: 'Admin::ReadAlsoModule')
      .delete_all
  end
end
