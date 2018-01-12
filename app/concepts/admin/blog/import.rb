# namespace to confine service class to Admin:BlogPost::Import
class Admin::Blog < ApplicationRecord
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

    private

    def build_options(row)
      {
        legacy_category_id: row[0].to_i,
        title: row[2].strip,
        locale: 'da'
      }
    end

    def import_category(options = {})
      Admin::Blog
        .where(legacy_category_id: options[:legacy_category_id])
        .first_or_create(options)
    end
  end
end
