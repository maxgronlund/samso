# namespace to confine service class to SectionPlugin::Service
class PageModule < ApplicationRecord
  # services for users
  class Service
    def initialize(resource)
      @resource = resource
    end

    # usage
    # PageModule::Service.new(resource).update_page_module(params)
    def update_page_module(options = {})
      @resource.page_module.update_attributes(
        position: options[:position],
        slot_id: options[:slot_id]
      )
    end
  end
end
