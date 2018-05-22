class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.belongs_to :user, foreign_key: true
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
