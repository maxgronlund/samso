# raw text section to place on a page
class CreateTextModules < ActiveRecord::Migration[5.1]
  def change
    create_table :text_modules do |t|
      t.string :title, default: ''
      t.text :body, default: ''

      t.timestamps
    end
  end
end
