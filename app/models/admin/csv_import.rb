# frozen_string_literal: true

# Import of legacy data
class Admin::CsvImport < ApplicationRecord
  # require 'csv'
  # require 'cgi'
  has_attached_file :csv_file
  validates_attachment_content_type :csv_file, content_type: %r{\Atext\/.*\Z}

  # usega
  # Admin::CsvImport.import_type_collection
  def self.import_type_collection
    [
      [I18n.t('csv_file.users'), User.name],
      [I18n.t('csv_file.articles'), Admin::BlogPost.name],
      [I18n.t('csv_file.catogories'), Admin::Blog.name],
      [I18n.t('csv_file.subscriptions'), Admin::Subscription.name]
    ]
  end

  def file_url
    'https:' + csv_file.url
  end

  def import_type_translation
    case import_type
    when 'User'
    when 'Admin::Blog'
      I18n.t('csv_file.catogories')
    when 'Admin::BlogPost'
      I18n.t('csv_file.articles')
    when 'User'
      I18n.t('csv_file.users')
    when 'Admin::Subscription'
      I18n.t('csv_file.subscriptions')
    end
  end
end
