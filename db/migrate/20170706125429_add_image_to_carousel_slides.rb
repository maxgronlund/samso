# Image for the slides
class AddImageToCarouselSlides < ActiveRecord::Migration[5.1]
  def up
    add_attachment :admin_carousel_slides, :image
  end

  def down
    remove_attachment :admin_carousel_slides, :image
  end
end
