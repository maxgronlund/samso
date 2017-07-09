# set root_path from admin system
class AddLandingPageToAdminSystemSetup < ActiveRecord::Migration[5.1]
  def up
    add_column :admin_system_setups, :da_landing_page_id, :integer
    add_column :admin_system_setups, :en_landing_page_id, :integer
    initialize_pages
  end

  def down
    remove_landing_pages
    remove_column :admin_system_setups, :da_landing_page_id
    remove_column :admin_system_setups, :en_landing_page_id
  end

  private

  def initialize_pages
    user_id = super_admin_id
    pages_params = [
      { title: 'Forside', menu_title: 'SAMSØ', menu_id: 'Ingen', locale: 'da', user_id: user_id, layout: 'alabama', active: true },
      { title: 'Front page', menu_title: 'SAMSØ', menu_id: 'None', locale: 'en', user_id: user_id, layout: 'alabama', active: true }
    ]

    create_pages(pages_params)
  end

  def super_admin_id
    role = Role.find_by(permission: Role::SUPER_ADMIN)
    role.user_id
  end

  def create_pages(pages_params = {})
    pages_params.each do |page_params|
      page = Page.where(page_params).first_or_create(page_params)
      update_system_setup(page_params[:locale], page.id)
    end
  end

  def update_system_setup(locale, page_id)
    Admin::SystemSetup.first.update_attributes(
      "#{locale}_landing_page_id".to_sym => page_id
    )
  end

  def remove_landing_pages
    system_setup = Admin::SystemSetup.first

    page_id = system_setup.da_landing_page_id
    page = Page.find_by(id: page_id)
    page.destroy if page

    page_id = system_setup.en_landing_page_id
    page = Page.find_by(id: page_id)
    page.destroy if page
  end
end
