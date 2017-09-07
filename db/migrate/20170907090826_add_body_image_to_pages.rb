class AddBodyImageToPages < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :pages, :body_background
  end
end
