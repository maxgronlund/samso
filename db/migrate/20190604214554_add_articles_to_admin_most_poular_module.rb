class AddArticlesToAdminMostPoularModule < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_most_popular_modules, :articles, :integer, default: 8
  end
end
