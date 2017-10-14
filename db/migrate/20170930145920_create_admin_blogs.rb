class CreateAdminBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_blogs do |t|
      t.string :title
      t.string :locale

      t.timestamps
    end
  end
end
