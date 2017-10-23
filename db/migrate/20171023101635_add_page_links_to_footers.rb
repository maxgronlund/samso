class AddPageLinksToFooters < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_footers, :about_page_id, :integer
    add_column :admin_footers, :about_page_link_name, :string, default: ''
    add_column :admin_footers, :copyright_page_id, :integer
    add_column :admin_footers, :copyright_page_link_name, :string, default: ''
    add_column :admin_footers, :term_of_usage_page_id, :integer
    add_column :admin_footers, :term_of_usage_page_link_name, :string, derault: ''
    add_column :admin_footers, :company_name, :string, derault: ''
    add_column :admin_footers, :phone, :string, derault: ''
    add_column :admin_footers, :vat_nr, :string, derault: ''

    remove_column :admin_footers, :about_link
    remove_column :admin_footers, :about_link_name
    remove_column :admin_footers, :email_name
    remove_column :admin_footers, :terms_of_usage_link
    remove_column :admin_footers, :terms_of_usage_link_name
    remove_column :admin_footers, :info
    remove_column :admin_footers, :copyright
  end

  def down

    add_column :admin_footers, :about_link, :string
    add_column :admin_footers, :about_link_name, :string
    add_column :admin_footers, :email_name, :string
    add_column :admin_footers, :terms_of_usage_link, :string
    add_column :admin_footers, :terms_of_usage_link_name, :string
    add_column :admin_footers, :info, :string
    add_column :admin_footers, :copyright, :string

    remove_column :admin_footers, :about_page_id
    remove_column :admin_footers, :about_page_link_name
    remove_column :admin_footers, :copyright_page_id
    remove_column :admin_footers, :copyright_page_link_name
    remove_column :admin_footers, :term_of_usage_page_id
    remove_column :admin_footers, :term_of_usage_page_link_name
    remove_column :admin_footers, :company_name, :string, derault: ''
    remove_column :admin_footers, :phone, :string, derault: ''
    remove_column :admin_footers, :vat_nr, :string, derault: ''
  end
end
