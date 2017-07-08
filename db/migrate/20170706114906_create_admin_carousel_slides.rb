# Slides for the carousel section
class CreateAdminCarouselSlides < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_carousel_slides do |t|
      t.string :title
      t.text :body
      t.integer :position
      t.integer :carousel_module_id

      t.timestamps
    end

    add_index :admin_carousel_slides, :carousel_module_id
  end
end
