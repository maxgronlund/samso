# namespace to confine service class to Admin:CsvImport::Service
class Admin::CsvImport < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Service
    def initialize(current_user)
      @current_user = current_user
    end

    # usage
    # Admin:CsvImport::Service.new.import(csv_import)
    def import(csv_import)
      csv = open(csv_import.file_url)

      case csv_import.import_type
      when User.name
        import_users(csv)
      when Admin::BlogPost.name
        import_blog_posts(csv)
      end
    end

    private

    def import_blog_posts(csv)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        formated_blog_post = format_blog_post(unescaped_row)
        import_blog_post(formated_blog_post(row))
      end
    end

    # rubocop:disable Style/MethodLength,
    def formated_blog_post(row)
      {
        legacy_id:                row[0].to_i,
        kategori_id:              row[1].to_i,
        startdato:                str_to_date_time(row[2]),
        slutdato:                 str_to_date_time(row[3]),
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
        opdateret_frontpagestory: str_to_date_time(row[17]),
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
      blog_module.blog_posts.new(

      )
      
      ap blog_module_id(options)
    end

    def blog_module_id(options = {})
      blog_module_options = {
        page_id: page_id(options)
      }
      # BlogModule.wherepage_id(options)
    end

    def setup_page(options = {})
      page_options = {
        title: options[:topstory],
        locale: 'da'
      }
      page = Page.first_or_initialize(page_options)
      initialize_page(page)
    end

    def setup_blog_module(page, options = {})
      blog_module_options = {
        name: options[:topstory]
      }
      blog_module
        .where(blog_module_options)
        .first_or_initialize(blog_module_options)
    end

    def initialize_page(page)
      return page if page.persisted?
      page.layout = 'arkansans'
      page.menu_id = 'Ingen'
      page.menu_position = Page.last.id * 10
      page.active = false
      page.user_id = @current_user.id
      page.require_subscription = true
      page.save
      page
    end

    def import_users(csv)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        import_user(unescaped_row)
      end
    end

    # rubocop:disable Metrics/PerceivedComplexity
    def import_user(row)
      options = {
        legacy_id: row[0] == '' ? nil : row[0].to_i,
        abonnr: row[1] == '' ? nil : row[1].to_i,
        navn: row[2].downcase.titleize,
        Adresse: row[3].downcase.titleize,
        Stednavn: row[4] == '' ? nil : row[4].downcase.titleize,
        Postnr_by: row[5] == '' ? nil : row[5].downcase.titleize,
        Telefon: row[6] == '' ? nil : row[6].downcase,
        Mobil: row[7] == '' ? nil : row[7].downcase,
        Nyhedsbrev: row[8] == '0' ? true : false,
        email: row[9] == '' ? fake_email : row[9].downcase,
        Brugernavn: row[10] == '' ? nil : row[10],
        password: row[11] == '' ? nil : row[11],
        abon_periode: row[12],
        Oprettet: row[13] == '' ? nil : row[13],
        Aktiv: row[14] == '0',
        UdloebsDato: row[15] == '' ? nil : row[15],
        SessionId: row[16],
        Friabon: row[17] == '0',
        Transact: row[18] == '' ? nil : row[18].to_i,
        Amount: row[19] == '' ? nil : row[15].to_i,
        TransactOpdateret: row[20] == '' ? nil : row[20],
        UpdateFriabon: row[21] == '0',
        UpdateAbon: row[22] == '0',
        BestilAbonavis: row[23] == '0',
        passivAbon: row[24] == '0'
      }
      create_or_update_user(options) unless options[:legacy_id].nil?
    end

    def fake_email
      SecureRandom.uuid + User::FAKE_EMAIL
    end

    def create_or_update_user(options = {})
      user          = find_or_create_user(options)
      user.name     = options[:navn]
      user.email    = options[:email]
      user.password = options[:password] unless options[:password].nil?
      user.save(validate: false)
      attach_role(user)
      options[:user_id] = user.id
      create_or_update_subscription(options)
    end

    def create_or_update_subscription(options = {})
      # action here
      return unless options[:abonnr]
      # subscription = Admin::Subscription.new
      # (
      #   user_id: options[:user_id]
      # )
    end

    def find_or_create_user(options = {})
      user = User.find_by(email: options[:email])
      return user unless user.nil?
      User
        .where(legacy_id: options[:legacy_id])
        .first_or_initialize
    end

    #                       :id => :integer,
    # :subscription_type_id => :integer,
    #             :duration => :string,
    #           :start_date => :date,
    #             :end_date => :date,
    #              :user_id => :integer,
    #           :created_at => :datetime,
    #           :updated_at => :datetime

    def attach_role(user)
      return if user.roles.any?
      Role.create(
        user_id: user.id,
        permission: Role::MEMBER,
        active: true
      )
    end

    def str_to_date_time(str)
      return '' if str.empty?
      date_time = str.split(' ')
      date = date_time[0].split('/')
      time = date_time[1].split(':')
      Time.new date[2], date[1], date[0], time[0], time[1], time[2], '+00:00'
    end
  end
end
