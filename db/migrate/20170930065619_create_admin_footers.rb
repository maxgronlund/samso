# page footer
class CreateAdminFooters < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_footers do |t|
      t.string :title, default: ''
      t.string :locale
      t.integer :about_page_id
      t.string :about_page_link_name, default: ''
      t.integer :copyright_page_id, :integer
      t.string :copyright_page_link_name, default: ''
      t.integer :term_of_usage_page_id, :integer
      t.string :term_of_usage_page_link_name, derault: ''
      t.string :email, default: ''
      t.string :company_name, default: ''
      t.string :phone, default: ''
      t.string :vat_nr, default: ''
      t.timestamps
    end
  end
end
