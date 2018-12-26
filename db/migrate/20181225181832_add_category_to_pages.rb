class AddCategoryToPages < ActiveRecord::Migration[5.2]
  def up
    add_column :pages, :category_page, :boolean, default: false
    add_column :admin_blogs, :index_page_id, :integer
    add_column :admin_blogs, :show_page_id, :integer
    add_index :admin_blogs, :show_page_id
    Page.find_each do |page|

      if page.title.include?('Kategori-')
        blog_title = page.title.gsub('Kategori-', '')
        blog = Admin::Blog.find_by(title: blog_title)
        blog.update(index_page_id: page.id) if blog.present?
        page.update(category_page: true)
      else
        blog = Admin::Blog.find_by(title: page.title)
        blog.update(show_page_id: page.id) if blog.present?
      end
    end
  end

  def down
    remove_column :pages, :category_page, :boolean
    remove_column :admin_blogs, :index_page_id
    remove_column :admin_blogs, :show_page_id
  end
end
