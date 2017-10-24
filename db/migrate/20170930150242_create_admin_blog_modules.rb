# blog
class CreateAdminBlogModules < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_blog_modules do |t|
      t.string :name
      t.text :body
      t.string :layout
      t.integer :post_page_id
      t.integer :blog_posts_count, default: 0
      t.integer :posts_pr_page, default: 10
      t.integer :admin_blog_id
      t.string :locale
      t.integer :admin_blog_post_category

      t.timestamps
    end
    add_index :admin_blog_modules, :post_page_id
    add_index :admin_blog_modules, :admin_blog_id
    add_module_name
  end

  def down
    drop_table :admin_blog_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::BlogModule', locale: 'admin/blog_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::BlogModule')
    module_name.delete unless module_name.nil?
  end
end
