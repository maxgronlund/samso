# namespace to confine service class to Admin:BlogPost::Import
class Admin::BlogPost < ApplicationRecord
  require 'csv'
  require 'cgi'
  # rubocop:disable Metrics/ClassLength
  # services for Admin::CsvImport
  class Import
    def initialize(current_user)
      @current_user = current_user
    end

    def import(csv_import)
      @errors = 0
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        import_blog_post(options)
      end
      Admin::BlogPostCategory.update_all_counts
    end

    # rubocop:disable Metrics/MethodLength,
    # rubocop:disable Metrics/AbcSize
    def build_options(row)
      {
        legacy_id: row[0].to_i,
        kategori_id: category_id(row[1].to_i),
        startdato: row[2].samso_import_to_datetime,
        slutdato: row[3].samso_import_to_datetime,
        topstory: row[4],
        titel: row[5],
        trompet: row[6],
        manchet: row[7],
        body: row[8],
        pix: row[9],
        pix_mappe: row[10],
        pix_alignment: row[11],
        pix_comment: row[12],
        signatur: row[13],
        email: row[14],
        comments: row[15],
        polls: row[16],
        opdateret_frontpagestory: row[17].samso_import_to_datetime,
        visning: row[19],
        # notes: row[19],
        # teaser: row[20],
        fokus: row[21],
        pix2: row[22],
        pix2_mappe: row[23],
        pix2_comment: row[24],
        galleri: row[25]
      }
    end

    def import_blog_post(options = {})
      blog = find_or_create_blog(options)
      post = setup_blog_post(blog, options)
      attach_image(post, options)
    end

    def setup_blog_post(blog, options = {})
      params = {
        title: options[:titel],
        subtitle: options[:trompet],
        teaser: options[:manchet],
        body: options[:body],
        admin_blog_post_category_id: options[:kategori_id],
        start_date: options[:startdato],
        end_date: options[:slutdato],
        user_id: user_id(options),
        views: options[:visning],
        signature: options[:signatur]
      }

      blog.posts.where(
        params
      ).first_or_create!(
        params
      )
    rescue => e
      Rails.logger.info e.message
    end

    def user_id(options = {})
      user =
        User.find_by(signature: options[:signature]) ||
        User.super_admin
      user.id
    end

    def attach_image(post, options = {})
      image_1_url = 'http://samso.dk/'
      image_1_url += options[:pix_mappe]
      image_1_url += options[:pix]
      image_1_url.gsub!(' ', '%20')
      return if image_1_url == 'http://samso.dk/'
      post.image = URI.parse(image_1_url)
      post.save
    rescue => e
      Rails.logger.info e.message
      @errors += 1
    end

    def last_blog_post_possition(blog_module)
      return 100 if blog_module.blog_posts.empty?
      blog_module.blog_posts.count * 100 + 100
    end

    def find_or_create_blog(options = {})
      category =
        Admin::BlogPostCategory
        .find(options[:kategori_id])

      params   = blog_params(category)
      Admin::Blog
        .where(params)
        .first_or_create(params)
    end

    def category_id(legacy_id)
      category(legacy_id).id
    end

    def category(legacy_id)
      find_or_create_category(legacy_id)
    end

    def find_or_create_category(legacy_id)
      Admin::BlogPostCategory
        .where(legacy_id: legacy_id)
        .first_or_create(name: 'default', locale: I18n.locale)
    end

    def blog_params(category)
      {
        title: category.name,
        locale: 'da',
        category_id: category.id
      }
    end
  end
end
