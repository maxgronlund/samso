# frozen_string_literal: true

# namespace to confine service class to Admin:CsvImport::Service
class Admin::CsvImport < ApplicationRecord
  # require 'csv'
  # require 'cgi'
  # services for Admin::CsvImport
  class Service
    def initialize(current_user)
      @current_user = current_user
    end

    # usage
    # Admin:CsvImport::Service.new.import(csv_import)
    # rubocop:disable Metrics/MethodLength
    def import(csv_import)
      case csv_import.import_type
      when User.name
        User::Import.new.import(csv_import)
      when Admin::BlogPost.name
        ::Admin::BlogPost::Import
          .new(@current_user)
          .import(csv_import)
      when Admin::Blog.name
        ::Admin::Blog::Import
          .new
          .import(csv_import)
      when Admin::Subscription.name
        ::Admin::Subscription::Import
          .new
          .import(csv_import)
      when Admin::Subscription::DaoImport.name
        ::Admin::Subscription::DaoImport
          .new
          .import(csv_import)
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
