# Shared functionalith between page_col_modules
module PageColConcerns
  extend ActiveSupport::Concern
  attr_accessor :position

  def position
    return nil if page_col_module.nil?
    page_col_module.position
  end

  def page_col_module
    page_col_modules.first
  end

  def page_col
    return nil if page_col_module.nil?
    page_col_module.page_col
  end

  def page
    return nil if page_col.nil?
    page_col.page
  end

  def update_position(new_position)
    page_col_module.update_attributes(position: new_position)
    clear_page_cache
  end

  # usage Admin::SystemSetup.clear_page_cache
  def clear_page_cache
    page.touch
  end
end
