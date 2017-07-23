# a dynamic blog can be added to a page
class CreateAdminBlogModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_blog_modules do |t|
      t.string :name
      t.text :body
      t.string :layout

      t.timestamps
    end
  end
end
