# Import of legacy data
class Admin::CsvImport < ApplicationRecord
  require 'csv'
  require 'cgi'
  has_attached_file :csv_file
  validates_attachment_content_type :csv_file, content_type: %r{\Atext\/.*\Z}

  def self.import_type_collection
    [
      [User.model_name.human, User.name]
    ]
  end

  def file_url
    source = 'https://s3.eu-central-1.amazonaws.com' + csv_file.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/avatars/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/users/avatars/missing/#{size.to_s}/missing.png'
    end
    source
  end

  def import_csv
    csv = open(file_url)
    CSV.parse(csv, headers: false).each do |row|
      user_data = row.map { |i| CGI.unescape(i.to_s) }
      ap user_data
    end
  end
end
