# page footer
class CreateAdminFooters < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_footers do |t|
      t.string :title, default: ''
      t.string :locale
      t.string :about_link, default: ''
      t.string :about_link_name, default: ''
      t.string :email, default: ''
      t.string :email_name, default: ''
      t.string :terms_of_usage_link, default: ''
      t.string :terms_of_usage_link_name, default: ''
      t.string :info, default: ''
      t.string :copyright, default: ''
      t.timestamps
    end
  end
end
