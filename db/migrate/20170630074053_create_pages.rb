# Page for dynamic content
class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :menu_title
      t.string :menu_id
      t.integer :menu_position, default: 0
      t.boolean :active
      t.string :locale
      t.belongs_to :user, foreign_key: false
      t.string :layout, default: 'alabama'

      t.timestamps
    end
  end
end
