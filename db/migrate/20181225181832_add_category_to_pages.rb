class AddCategoryToPages < ActiveRecord::Migration[5.2]
  def up
    add_column :pages, :category_page, :boolean, default: false
    add_column :pages, :blog_id, :integer
    add_index :pages, :blog_id
    Admin::Blog.find_each do |blog|
      page_title   = 'Kategori-' + blog.title
      page         = Page.find_by(title: page_title)
      page.blog_id = blog.id
      page.category_page = true
      page.save!
    end
  end

  def down
    remove_column :pages, :category_page, :boolean
    remove_column :pages, :blog_id
  end
end
