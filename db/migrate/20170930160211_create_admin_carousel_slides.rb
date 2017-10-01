# slide for the carousel
class CreateAdminCarouselSlides < ActiveRecord::Migration[5.1]
  def up
    create_table :admin_carousel_slides do |t|
      t.string :title
      t.text :body
      t.integer :position, default: 0
      t.integer :page_id
      t.integer :carousel_module_id

      t.timestamps
    end

    add_index :admin_carousel_slides, :page_id
    add_index :admin_carousel_slides, :carousel_module_id
    add_attachment :admin_carousel_slides, :image
  end

  def down
    drop_table :admin_carousel_slides
  end
end
