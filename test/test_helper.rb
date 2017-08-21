require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# include Warden::Test::Helpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
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
