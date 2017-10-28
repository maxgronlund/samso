# Limit selection of blogmodules to selected language
class AddLocaleToAdminBlogModules < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_blog_modules, :locale, :string, default: 'en'
  end
end
