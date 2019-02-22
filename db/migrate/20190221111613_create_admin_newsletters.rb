class CreateAdminNewsletters < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_newsletters do |t|
      t.string :locale
      t.string :title, default: ''
      t.text :body, default: ''

      t.timestamps
    end
  end
end
