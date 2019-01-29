class CreateAdminPrintedAds < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_printed_ads do |t|
      t.string :title, default: ''
      t.text :body, default: ''
      t.integer :impressions, default: 0
      t.boolean :active, default: false
      t.integer :position, default: 0

      # Image
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
