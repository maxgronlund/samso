# frozen_string_literal: true

# module for showing a blog post
class CreateAdminPostModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_post_modules do |t|
      t.string :name

      t.timestamps
    end
    add_module_name
  end

  def down
    drop_table :admin_post_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::PostModule', locale: 'admin/post_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::PostModule')
    module_name.delete if module_name.present?
  end
end
