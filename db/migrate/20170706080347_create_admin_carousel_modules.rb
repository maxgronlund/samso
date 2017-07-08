# Carousel section
class CreateAdminCarouselModules < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_carousel_modules do |t|
      t.string :name
      t.string :layout

      t.timestamps
    end
  end
end
