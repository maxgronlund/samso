# frozen_string_literal: true

# blog to embed in BlogModule
class CreateAdminBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_blogs do |t|
      t.string :title
      t.string :locale
      t.integer :legacy_category_id

      t.timestamps
    end
  end
end
