class AddBackgroundColorToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :background_color, :string, default: 'none'
  end
end
