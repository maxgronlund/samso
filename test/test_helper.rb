require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Warden::Test::Helpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
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
