# helpers for the TextModule
module TextModuleHelper
  def text_module_link_helper(text_module)
    return page_path(text_module.page_id) unless text_module.page_id.nil?
    return url unless text_module.url.empty?

    '#'
  end
end
