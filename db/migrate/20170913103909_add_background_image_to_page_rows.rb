# Image on a row
class AddBackgroundImageToPageRows < ActiveRecord::Migration[5.1]
  def change
    add_attachment :page_rows, :background_image
  end
end
