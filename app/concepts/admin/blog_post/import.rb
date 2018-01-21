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
      Admin::Blog.update_all_counts
      pritify_layouts
    end

    def pritify_layouts
      Admin::Blog.find_each do |blog|
        pritify_blog_posts(
          blog.posts
        )
      end
    end

    def pritify_blog_posts(blog_posts)
      count = 1
      blog_posts.find_each do |blog_post|
        layout = count.even? ? 'image_left' : 'image_right'
        blog_post.update_attributes(layout: layout)
        count += 1
      end
    end

    # rubocop:disable Metrics/MethodLength,
    # rubocop:disable Metrics/AbcSize
    def build_options(row)
      {
        legacy_id: row[0].to_i,
        legacy_category_id: row[1].to_i,
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
    # rubocop:enable Metrics/MethodLength,
    # rubocop:enable Metrics/AbcSize

    def import_blog_post(options = {})
      blog       = find_or_create_blog(options)
      menu_title = "Kategori #{blog.title}"
      page       = Page.find_by(menu_title: menu_title)
      return if page.nil?
      options[:post_page_id] = page.id
      post = find_or_initialize_blog_post(blog, options)
      return if post.nil? || post.persisted?
      post.save
      attach_image(post, options)
    end

    def find_or_initialize_blog_post(blog, options = {})
      options = blog_post_options(options)
      blog.posts.where(
        body: options[:body]
      ).first_or_initialize(
        options
      )
    rescue => e
      Rails.logger.info e.message
      nil
    end

    def blog_post_options(options = {})
      {
        title: options[:titel],
        subtitle: options[:trompet],
        teaser: options[:manchet],
        body: options[:body],
        start_date: options[:startdato],
        end_date: options[:slutdato],
        user_id: user_id(options),
        views: options[:visning],
        signature: options[:signatur],
        post_page_id: options[:post_page_id]
      }
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
      Admin::Blog.where(legacy_category_id: options[:legacy_category_id])
      Admin::Blog
        .where(legacy_category_id: options[:legacy_category_id])
        .first_or_initialize(
          legacy_category_id: options[:legacy_category_id],
          title: options[:title]
        )
    end
  end
end
# rubocop:enable Metrics/ClassLength
