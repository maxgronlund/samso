# namespace to confine service class to Admin:CsvImport::Service
class User < ApplicationRecord
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
        import_user(unescaped_row)
      end
    end

    private

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Style/MethodLength
    def import_user(row)
      options = {
        legacy_id: row[0].empty? ? nil : row[0].to_i,
        abonnr: row[1].empty? ? nil : row[1].to_i,
        navn: row[2].downcase.titleize,
        Adresse: row[3].downcase.titleize,
        Stednavn: row[4].empty? ? nil : row[4].downcase.titleize,
        Postnr_by: row[5].empty? ? nil : row[5].downcase.titleize,
        Telefon: row[6].empty? ? nil : row[6].downcase,
        Mobil: row[7].empty? ? nil : row[7].downcase,
        Nyhedsbrev: row[8] == '0' ? true : false,
        email: row[9].empty? ? fake_email : row[9].downcase,
        Brugernavn: row[10].empty? ? nil : row[10],
        password: row[11].empty? ? nil : row[11],
        abon_periode: row[12],
        Oprettet: row[13].empty? ? nil : row[13],
        Aktiv: row[14] == '0',
        UdloebsDato: row[15].empty? ? nil : row[15],
        SessionId: row[16],
        Friabon: row[17] == '0',
        Transact: row[18].empty? ? nil : row[18].to_i,
        Amount: row[19].empty? ? nil : row[15].to_i,
        TransactOpdateret: row[20].empty? ? nil : row[20],
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
      if options[:password].nil?
        user.password_digest = User::Service.fake_password
      else
        user.password = options[:password]
      end

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
