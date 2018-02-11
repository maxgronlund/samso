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
        Abonnr: row[1].strip,
        navn: row[2].strip.downcase.titleize,
        Adresse: row[3].strip.downcase.titleize,
        Stednavn: row[4].empty? ? nil : row[4].strip.downcase.titleize,
        Postnr_by: row[5].empty? ? nil : row[5].strip.downcase.titleize,
        Telefon: row[6].empty? ? nil : row[6].strip.downcase,
        Mobil: row[7].empty? ? nil : row[7].strip.downcase,
        Nyhedsbrev: row[8] == '0',
        email: User::Service.sanitize_email(row[9]),
        Brugernavn: row[10].empty? ? nil : row[10].strip,
        password: row[11].empty? ? nil : row[11].strip,
        Abon_periode: row[12],
        Oprettet: row[13].empty? ? nil : row[13].strip.samso_import_to_datetime,
        Aktiv: row[14] == '0',
        UdloebsDato: row[15].empty? ? nil : row[15].strip.samso_import_to_datetime,
        SessionId: row[16],
        Friabon: row[17] == '0',
        Transact: row[18].empty? ? nil : row[18].to_i,
        Amount: row[19].empty? ? nil : row[19].to_i,
        TransactOpdateret: row[20].empty? ? nil : row[20],
        UpdateFriabon: row[21] == '0',
        UpdateAbon: row[22] == '0',
        bestil_abonavis: row[23] == '0',
        passivAbon: row[24] == '0'
      }
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def create_or_update_user(options = {})
      user = find_or_initialize_user(options)
      return if user.nil?

      secure_password(user, options)
      user.legacy_subscription_id = legacy_subscription_id(options)
      user.confirmed_at = DateTime.now if user.confirmed_at.nil?
      user.name = options[:navn]
      user.signature = options[:navn]
      user.email = options[:email]
      user.save(validate: false)
      attach_role(user)
      options[:user_id] = user.id
      create_or_update_subscription(user, options) unless options[:Abon_periode].to_i.zero?
    rescue => e
      Rails.logger.info '===================== unable to import user ====================='
      Rails.logger.info options
      Rails.logger.info e.message
      Rails.logger.info '-------------'
      Rails.logger.info e.backtrace
      Rails.logger.info '================================================================='
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def legacy_subscription_id(options = {})
      return Admin::Subscription.new_safe_subscription_id if options[:Abonnr].nil? || options[:Abonnr].empty?
      options[:Abonnr]
    end

    def secure_password(user, options)
      if options[:password].nil?
        user.password_digest = User::Service.fake_password
      else
        user.password = options[:password]
      end
    end

    def create_or_update_subscription(user, options = {})
      subscription = first_or_initialize_subscription(user, options)
      subscription.user_id = user.id
      subscription.subscription_type_id = first_or_create_subscription_type(options)
      subscription.start_date = options[:Oprettet]
      subscription.end_date = subscription_end_date(options)
      subscription.subscription_id = subscription_id(options)
      subscription.save
    end

    def subscription_end_date(options = {})
      return calculated_subscription_end_date(options) if options[:UdloebsDato].nil?
      options[:UdloebsDato]
    end

    def calculated_subscription_end_date(options = {})
      oprettet = options[:Oprettet]
      abon_periode = options[:Abon_periode].to_i
      oprettet = Time.zone.now - 1.year if oprettet.nil?
      oprettet + abon_periode.days
    end

    def first_or_create_subscription_type(options)
      Admin::SubscriptionType
        .where(
          duration: options[:Abon_periode].to_i,
          print_version: options[:bestil_abonavis],
          internet_version: true
        )
        .first_or_create(
          duration: options[:Abon_periode].to_i,
          print_version: options[:bestil_abonavis],
          internet_version: true
        ).id
    end

    def first_or_initialize_subscription(user, options)
      user
        .subscriptions
        .where(subscription_id: options[:Abonnr])
        .first_or_initialize
    end

    def subscription_id(options = {})
      return Admin::Subscription.count + 10000000 if options[:Abonnr].nil? || options[:Abonnr].empty?
      options[:Abonnr]
    end

    def find_or_initialize_user(options = {})
      user = find_user_by_legacy_subscription_id(options)
      user = find_user_by_legacy_id(options) if user.nil?
      user = find_user_by_email(options) if user.nil?
      return user unless user.nil?
      User
        .where(legacy_id: options[:legacy_id])
        .first_or_initialize
    end

    def find_user_by_email(options = {})
      User.find_by(email: options[:email])
    end

    def find_user_by_legacy_id(options = {})
      return nil if options[:legacy_id].to_s.empty?
      User.find_by(legacy_id: options[:legacy_id])
    end

    def find_user_by_legacy_subscription_id(options = {})
      return nil if options[:Abonnr].to_s.empty?
      User.find_by(legacy_subscription_id: options[:Abonnr])
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
# rubocop:enable Metrics/ClassLength
