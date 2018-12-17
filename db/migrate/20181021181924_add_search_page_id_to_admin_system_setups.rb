# frozen_string_literal: true

# id for search page
class AddSearchPageIdToAdminSystemSetups < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_system_setups, :search_page_id, :integer
  end
end
