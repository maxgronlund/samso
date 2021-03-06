# frozen_string_literal: true

# blog
class CreateAdminBlogModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_blog_modules do |t|
      t.string :name
      t.text :body
      t.string :layout
      t.integer :blog_posts_count, default: 0
      t.integer :posts_pr_page, default: 10
      t.integer :admin_blog_id
      t.string :locale
      t.boolean :show_all_categories, default: false
      t.integer :featured_posts_pr_page, default: 0
      t.boolean :show_search, default: false

      t.timestamps
    end
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
    module_name.delete if module_name.present?
  end
end
