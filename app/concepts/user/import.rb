# namespace to confine service class to Admin:CsvImport::Service
class User < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  # rubocop:disable Metrics/ClassLength
  class Import
    def initialize(current_user)
      @current_user = current_user
    end

    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        create_or_update_user(options) unless options[:legacy_id].nil?
      end
    end

    private

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def build_options(row)
      {
        legacy_id: row[0].empty? ? nil : row[0].to_i,
        abonnr: row[1].empty? ? nil : row[1].to_i,
        navn: row[2].downcase.titleize,
        Adresse: row[3].downcase.titleize,
        Stednavn: row[4].empty? ? nil : row[4].downcase.titleize,
        Postnr_by: row[5].empty? ? nil : row[5].downcase.titleize,
        Telefon: row[6].empty? ? nil : row[6].downcase,
        Mobil: row[7].empty? ? nil : row[7].downcase,
        Nyhedsbrev: row[8] == '0' ? true : false,
        email: row[9].empty? ? fake_email : row[9].downcase.delete(' '),
        Brugernavn: row[10].empty? ? nil : row[10],
        password: row[11].empty? ? nil : row[11],
        abon_periode: row[12],
        Oprettet: row[13].empty? ? nil : row[13].samso_import_to_datetime,
        Aktiv: row[14] == '0',
        UdloebsDato: row[15].empty? ? nil : row[15],
        SessionId: row[16],
        Friabon: row[17] == '0',
        Transact: row[18].empty? ? nil : row[18].to_i,
        Amount: row[19].empty? ? nil : row[15].to_i,
        TransactOpdateret: row[20].empty? ? nil : row[20],
        UpdateFriabon: row[21] == '0',
        UpdateAbon: row[22] == '0',
        bestil_abonavis: row[23] == '0',
        passivAbon: row[24] == '0'
      }
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/MethodLength

    def fake_email
      SecureRandom.uuid + User::FAKE_EMAIL
    end

    def create_or_update_user(options = {})
      user = find_or_create_user(options)
      return if user.nil?
      secure_email(user, options)
      secure_password(user, options)

      user.save(validate: false)
      attach_role(user)
      options[:user_id] = user.id
      create_or_update_subscription(options)
    rescue
      Rails.logger.info '===================== unable to import user ====================='
      Rails.logger.info options
      Rails.logger.info '================================================================='
    end

    def secure_email(user, options)
      User::Service.sanitize_email(options)
      unless User::Service.valid_email?(options)
        options[:email] = User::Service.fake_email
      end
      user.name     = options[:navn]
      user.email    = options[:email]
    end

    def secure_password(user, options)
      if options[:password].nil?
        user.password_digest = User::Service.fake_password
      else
        user.password = options[:password]
      end
    end

    def create_or_update_subscription(options = {})
      return unless options[:abonnr]
      return if options[:abon_periode].to_i.zero?
      subscription = find_or_create_subscription(options)
      subscription.user_id = @current_user.id
      subscription.subscription_type_id = subscription_type_id(options)
      subscription.save
    end

    def subscription_type_id(options)
      Admin::SubscriptionType
        .where(
          duration: options[:abon_periode].to_i,
          print_version: options[:bestil_abonavis],
          internet_version: true
        )
        .first_or_create(
          duration: options[:abon_periode].to_i,
          print_version: options[:bestil_abonavis],
          internet_version: true
        ).id
    end

    def find_or_create_subscription(options)
      Admin::Subscription
        .where(subscription_id: options[:abonnr])
        .first_or_initialize
    end

    def find_or_create_user(options = {})
      user = User.find_by(email: options[:email])
      return user unless user.nil?
      User
        .where(legacy_id: options[:legacy_id])
        .first_or_initialize
    end

    def attach_role(user)
      return if user.roles.any?
      Role.create(
        user_id: user.id,
        permission: Role::MEMBER,
        active: true
      )
    end
  end
end
