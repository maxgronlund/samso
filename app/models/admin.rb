# db wrapper for the admin namespace
module Admin
  def self.table_name_prefix
    'admin_'
  end
end
