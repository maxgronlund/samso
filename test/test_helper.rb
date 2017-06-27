require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  module Behavior
    module LocaleParameter
      def process(action, params: {}, **args)
        params[:locale] = I18n.locale
        super(action, params: params, **args)
      end
    end
  end
  prepend Behavior::LocaleParameter
end
