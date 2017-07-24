# Shared functionalith between page_modules
module SectionPlugin
  extend ActiveSupport::Concern
  attr_accessor :position
  attr_accessor :slot_id

  def position
    page_module.position
  end

  def slot_id
    page_module.slot_id
  end

  def page
    page_module.page
  end
end
