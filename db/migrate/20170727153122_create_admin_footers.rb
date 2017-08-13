# footers to show on multiply pages
class CreateAdminFooters < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_footers do |t|
      t.string :title
      t.string :locale
      t.string :about_link
      t.string :about_link_name
      t.string :email
      t.string :email_name
      t.string :terms_of_usage_link
      t.string :terms_of_usage_link_name
      t.string :info
      t.string :copyright

      t.timestamps
    end

    add_column :pages, :footer_id, :integer
    add_index  :pages, :footer_id
  end
end
