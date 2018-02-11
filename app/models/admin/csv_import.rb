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
      [User.model_name.human, User.name],
      [Admin::BlogPost.model_name.human, Admin::BlogPost.name],
      [Admin::Blog.model_name.human, Admin::Blog.name],
      ['E-Conomics export', Admin::Subscription.name]
    ]
  end

  def file_url
    'https:' + csv_file.url
  end
end
