# namespace to confine service class to Admin:BlogPost::Import
class Admin::BlogPostCategory < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    def initialize
    end

    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        import_category(options)
      end
    end

    def build_options(row)
      {
        legacy_id: row[0].to_i,
        name: row[2],
        active: true,
        locale: 'da'
      }
    end

    def import_category(options = {})
      Admin::BlogPostCategory
        .where(options)
        .first_or_create(options)
    end
  end
end
