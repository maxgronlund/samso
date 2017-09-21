# Dynamical storages of module names
# TODO: expand with image url for preview
class Admin::ModuleName < ApplicationRecord
  # List of module class names and translations
  # usage Admin::ModuleName.module_names
  def self.module_names
    Admin::ModuleName.all.map do |module_name|
      [
        I18n.t(module_name.name.underscore + '.name'),
        module_name.name
      ]
    end
  end
end
