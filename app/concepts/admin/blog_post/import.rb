# namespace to confine service class to Admin:BlogPost::Import
class Admin::BlogPost < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    def initialize(current_user)
      @current_user = current_user
    end

    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        import_blog_post(options)
      end
    end

    # rubocop:disable Style/MethodLength,
    # rubocop:disable Style/AbcSize
    def build_options(row)
      {
        legacy_id:                row[0].to_i,
        kategori_id:              row[1].to_i,
        startdato:                row[2].samso_import_to_datetime,
        slutdato:                 row[3].samso_import_to_datetime,
        topstory:                 row[4],
        titel:                    row[5],
        trompet:                  row[6],
        manchet:                  row[7],
        body:                     row[8],
        pix:                      row[9],
        pix_mappe:                row[10],
        pix_alignment:            row[11],
        pix_comment:              row[12],
        signatur:                 row[13],
        email:                    row[14],
        comments:                 row[15],
        polls:                    row[16],
        opdateret_frontpagestory: row[17].samso_import_to_datetime,
        visning:                  row[18],
        notes:                    row[19],
        teaser:                   row[20],
        fokus:                    row[21],
        pix2:                     row[22],
        pix2_mappe:               row[23],
        pix2_comment:             row[24],
        galleri:                  row[25]
      }
    end

    def import_blog_post(options = {})
      ap options
      # page        = setup_page(options)
      # blog_module = setup_blog_module(page, options)
      # blog_module.blog_posts.new
      # ap blog_module_id(options)
    end

    # def blog_module_id(options = {})
    #   blog_module_options = {
    #     page_id: page_id(options)
    #   }
    #   # BlogModule.wherepage_id(options)
    # end

    # def setup_page(options = {})
    #   page_options = {
    #     title: options[:topstory],
    #     locale: 'da'
    #   }
    #   page = Page.first_or_initialize(page_options)
    #   initialize_page(page)
    # end

    # def setup_blog_module(page, options = {})
    #   blog_module_options = {
    #     name: options[:topstory]
    #   }
    #   blog_module
    #     .where(blog_module_options)
    #     .first_or_initialize(blog_module_options)
    # end

    # def initialize_page(page)
    #   return page if page.persisted?
    #   page.layout = 'arkansans'
    #   page.menu_id = 'Ingen'
    #   page.menu_position = Page.last.id * 10
    #   page.active = false
    #   page.user_id = @current_user.id
    #   page.require_subscription = true
    #   page.save
    #   page
    # end
  end
end
