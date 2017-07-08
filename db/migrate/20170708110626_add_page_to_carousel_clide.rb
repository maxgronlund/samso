# link to a page
class AddPageToCarouselClide < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_carousel_slides, :page_id, :integer
    add_index :admin_carousel_slides, :page_id
  end
end
