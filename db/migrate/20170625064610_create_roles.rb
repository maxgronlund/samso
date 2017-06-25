class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :permission, default: Role::MEMBER
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
