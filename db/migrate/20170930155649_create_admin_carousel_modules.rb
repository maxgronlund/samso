# frozen_string_literal: true

# bootstrap slider
class CreateAdminCarouselModules < ActiveRecord::Migration[6.0]
  def up
    create_table :admin_carousel_modules do |t|
      t.string :name
      t.string :layout

      t.timestamps
    end
    add_module_name
  end

  def down
    drop_table :admin_carousel_modules
    remove_module_name
  end

  private

  def add_module_name
    position = Admin::ModuleName.count
    params = { name: 'Admin::CarouselModule', locale: 'admin/carousel_module.name', position: position + 1 }
    Admin::ModuleName
      .where(params)
      .first_or_create(params)
  end

  def remove_module_name
    module_name = Admin::ModuleName.find_by(name: 'Admin::CarouselModule')
    module_name.delete if module_name.present?
  end
end
