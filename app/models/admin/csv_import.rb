class Admin::CsvImport < ApplicationRecord
  require 'csv'
  has_attached_file :csv_file
  # validates_attachment :csv_file, content_type: { content_type: "text/csv" }
  validates_attachment_content_type :csv_file, content_type: %r{\Atext\/.*\Z}
  # , size: { in: 0..10.kilobytes }

	def self.import_type_collection
    [
      [User.model_name.human, User.name]
    ]
  end

  def file_url
    source = 'https://s3.eu-central-1.amazonaws.com' + csv_file.url().gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/avatars/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/users/avatars/missing/#{size.to_s}/missing.png'
    end
    source
  end

  def import_csv
    #csv = File.read(file_url)
    csv  = open(file_url) {|f| f.read }
    ap csv

    CSV.parse(csv, headers: true).each do |row|
      ap row
    end
  end
end
