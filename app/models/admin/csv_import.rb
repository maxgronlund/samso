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
      [Admin::BlogPost.model_name.human, Admin::BlogPost.name]
    ]
  end

  def file_url
    source = 'https://s3.eu-central-1.amazonaws.com' + csv_file.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/avatars/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/users/avatars/missing/#{size.to_s}/missing.png'
    end
    source
  end

  def parse_file(current_user)
    import_service = Admin::CsvImport::Service.new(current_user)
    import_service.import(self)
  end
end
