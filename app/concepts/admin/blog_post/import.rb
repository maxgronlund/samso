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

    # rubocop:disable Metrics/MethodLength,
    # rubocop:disable Metrics/AbcSize
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
      page        = setup_page(options)
      blog_module = setup_blog_module(page, options)
      setup_page_module(page, blog_module)
      post = setup_blog_post(blog_module, options)
      attach_image(post, options)
    end

    def setup_blog_post(blog_module, options = {})
      

      params = {
        title: options[:titel],
        subtitle: options[:trompet],
        teaser: options[:manchet],
        body: options[:body],
        start_date: options[:startdato],
        end_date: options[:slutdato]
      }

      blog_module.posts.where(
        params
      ).first_or_create(
        params
      ) 
    end

    def attach_image(post, options = {})
      image_1_url = 'http://samso.dk/'
      image_1_url += options[:pix_mappe]
      image_1_url += options[:pix]
      image_1_url.delete(' ')
      return if image_1_url == "http://samso.dk/"
      post.image = URI.parse(image_1_url)
      post.save
    end

    def last_blog_post_possition(blog_module)
      return 100 if blog_module.blog_posts.empty?
      blog_module.blog_posts.count * 100 + 100
    end

    def setup_page(options = {})
      params = {
        title: options[:topstory],
        locale: 'da',
        user_id: User.super_admin.id,
        layout: 'arkansas'
      }
      Page
        .where(params)
        .first_or_create(params)
    end

    def setup_blog_module(page, options = {})
      params = {
        name: options[:topstory]
      }
      Admin::BlogModule
        .where(params)
        .first_or_create(params)

    end

    def setup_page_module(page, blog_module)
      params =
      {
        page_id: page.id,
        moduleable_type: blog_module.class.name,
        moduleable_id: blog_module.id,
        slot_id: 200
      }
      PageModule
        .where(params)
        .first_or_create(params)
    end


  end
end
