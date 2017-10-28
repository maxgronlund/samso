# page footer
# rubocop:disable Metric/AbcSize
class CreateAdminFooters < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_footers do |t|
      t.string :title, default: ''
      t.string :locale
      f.integer :about_page_id
      f.string :about_page_link_name, default: ''
      f.integer :copyright_page_id, :integer
      f.string :copyright_page_link_name, default: ''
      f.integer :term_of_usage_page_id, :integer
      f.string :term_of_usage_page_link_name, derault: ''
      t.string :email, default: ''
      t.string :company_name, default: ''
      t.string :phone, default: ''
      t.string :vat_nr, default: ''
      t.timestamps
    end
  end
end
