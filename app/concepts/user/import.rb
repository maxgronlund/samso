# namespace to confine service class to Admin:CsvImport::Service
class User < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  # rubocop:disable Metrics/ClassLength

  A = 0
  B = 1
  C = 2
  D = 3
  E = 4
  F = 5
  G = 6
  H = 7
  I = 8
  J = 9
  K = 10
  L = 11
  M = 12
  N = 13
  O = 14
  P = 15
  Q = 16
  R = 17
  S = 18
  T = 19
  U = 20
  V = 21
  W = 22
  X = 23
  Y = 24

  # importer
  class Import
    def initialize(current_user)
      @current_user = current_user
    end

    # rubocop:disable Security/Open
    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        create_or_update_user(options) unless options[:legacy_id].nil?
      end
    end
    # rubocop:enable Security/Open

    private

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def build_options(row)
      ap row
      {
        legacy_id: row[A].empty? ? nil : row[A].to_i,
        Abonnr: row[B].strip,
        navn: row[C].strip.downcase.titleize,
        adresse: row[D].strip.downcase.titleize,
        Stednavn: row[E].empty? ? nil : row[E].strip.downcase.titleize,
        postnr_by: row[F].empty? ? nil : row[F].strip.downcase.titleize,
        Telefon: row[G].empty? ? nil : row[G].strip.downcase,
        Mobil: row[H].empty? ? nil : row[H].strip.downcase,
        Nyhedsbrev: row[U] == '0',
        email: User::Service.sanitize_email(row[J]),
        Brugernavn: row[K].empty? ? nil : row[K].strip,
        password: row[L].empty? ? nil : row[L].strip,
        Abon_periode: row[M],
        Oprettet: row[N].empty? ? nil : row[N].strip.samso_import_to_datetime,
        Aktiv: row[O] == '0',
        UdloebsDato: row[P].empty? ? nil : row[P].strip.samso_import_to_datetime,
        SessionId: row[Q],
        Friabon: row[R] == '0',
        Transact: row[S].empty? ? nil : row[S].to_i,
        Amount: row[T].empty? ? nil : row[T].to_i,
        TransactOpdateret: row[U].empty? ? nil : row[U],
        UpdateFriabon: row[V] == '0',
        UpdateAbon: row[W] == '0',
        bestil_abonavis: row[X] == '0',
        passivAbon: row[Y] == '0'
      }
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def create_or_update_user(options = {})
      user = find_or_initialize_user(options)
      return if user.nil? || user.persisted?

      secure_password(user, options)
      user.legacy_subscription_id = legacy_subscription_id(options)
      user.confirmed_at = DateTime.now if user.confirmed_at.nil?
      user.name = options[:navn]
      user.signature = options[:navn]
      user.email = options[:email]
      if user.save(validate: false)
        attach_role(user)
        attach_address(user, options)
        options[:user_id] = user.id
        create_or_update_subscription(user, options)
      end
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
      return if options[:Abon_periode].to_i.zero?

      subscription = first_or_initialize_subscription(user, options)
      subscription.subscription_type_id = first_or_create_subscription_type(options)
      subscription.start_date = options[:Oprettet]
      subscription.end_date = subscription_end_date(options)
      subscription.subscription_id = subscription_id(options)
      create_subscription_address(subscription) if subscription.save
    end

    def create_subscription_address(subscription)
      return unless subscription.addresses.empty?

      user = subscription.user
      subscription
        .addresses
        .create(
          name: user.name,
          address: user.street_address,
          city: user.city,
          zipp_code: user.zipp_code
        )
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

      User.new
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

    def attach_address(user, options = {})
      create_user_address(user, options) if user.addresses.empty?
    end

    def create_user_address(user, options = {})
      address           = user.addresses.new
      zipp_code         = parse_zipp_code(options)
      city              = parse_city(zipp_code, options)
      address.zipp_code = zipp_code if zipp_code.present?
      address.city      = city if city.present?
      address.name      = user.name
      address.address   = options[:adresse]
      address.save
    end

    def parse_zipp_code(options = {})
      zipp_code = postal_code_and_city(options).first.to_s
      return zipp_code if Address::Service::ZIP_CODE_TO_CITY[zipp_code.to_sym].present?

      nil
    end

    def parse_city(zipp_code, options)
      city = Address::Service::ZIP_CODE_TO_CITY[zipp_code.to_s.to_sym]
      return city if city.present?

      city = postal_code_and_city(options)
      city.delete_at(0) if city.is_a?(Array) && city.length > 1
      city.join(' ')
    end

    def postal_code_and_city(options = {})
      return [] if options[:postnr_by].blank?

      options[:postnr_by].split
    end
  end
end
# rubocop:enable Metrics/ClassLength
