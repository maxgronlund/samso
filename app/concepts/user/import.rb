# old users
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
    # rubocop:disable Security/Open
    def import(csv_import)
      @succeeded = 0
      @persisted = []
      @failed = []
      csv_file = open(csv_import.file_url)
      CSV.parse(csv_file, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = parsed_row(unescaped_row)
        import_user(options) unless options[:user_id].blank?
      end
      Rails.logger.info '===================== IMPORT OF USERS ========================='
      Rails.logger.info "Succeeded: #{@succeeded}"
      log_failed if @failed.any?
      log_persisted if @persisted.any?

      Rails.logger.info '==============================================================='

      # import_subscriptions(csv_import)
    end
    # rubocop:enable Security/Open

    private

    def log_failed
      Rails.logger.info "Failed: #{@failed.length}"
      @failed.each do |failed|
        Rails.logger.info '--------------------------------'
        failed.each do |k,v|
          Rails.logger.info "#{k}: #{v}"
        end
      end
    end

    def log_persisted
      Rails.logger.info "Persisted: #{@persisted.length}"
      @persisted.each do |persisted|
        Rails.logger.info '--------------------------------'
        persisted.each do |k,v|
          Rails.logger.info "#{k}: #{v}"
        end
      end
    end

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def parsed_row(row)
      {
        user_id: row[A].empty? ? nil : row[A].to_i,
        Abonnr: build_subscription_id(row),
        navn: row[C].strip.downcase.titleize,
        adresse: row[D].strip.downcase.titleize,
        Stednavn: row[E].empty? ? nil : row[E].strip.downcase.titleize,
        postnr_by: row[F].empty? ? nil : row[F].strip.downcase.titleize,
        Telefon: row[G].empty? ? nil : row[G].strip.downcase,
        Mobil: row[H].empty? ? nil : row[H].strip.downcase,
        Nyhedsbrev: row[U].present?,
        email: User::Service.sanitize_email(row[J]),
        Brugernavn: row[K].empty? ? nil : row[K].strip,
        password: row[L].empty? ? nil : row[L].strip,
        Abon_periode: row[M].to_i,
        Oprettet: row[N].empty? ? nil : row[N].strip.samso_import_to_datetime,
        Aktiv: row[O] == '0',
        UdloebsDato: row[P].empty? ? nil : row[P].strip.samso_import_to_datetime,
        SessionId: row[Q],
        Friabon: row[R] == '1',
        Transact: row[S].empty? ? nil : row[S].to_i,
        Amount: row[T].empty? ? nil : row[T].to_i,
        TransactOpdateret: row[U].empty? ? nil : row[U],
        UpdateFriabon: row[V] == '0',
        UpdateAbon: row[W] == '0',
        bestil_abonavis: row[X] == '1',
        passivAbon: row[Y] == '0'
      }
    end

    def build_subscription_id(row)
      subscription_id = row[B].strip
      subscription_id.presence ||  User.new_user_id
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def import_user(options = {})
      user = User.where(user_id: options[:Abonnr]).first_or_initialize
      email = User::Service.sanitize_email(options[:email])
      if user.persisted? || User.exists?(email: email)
        user.update(subscribe_to_news: options[:Nyhedsbrev])
        @persisted << {options: options, user: user.attributes, subscription: user.subscriptions}
        return
      end

      User::Service.set_password(user, options[:password])
      user.confirmed_at = DateTime.now
      user.name = options[:navn]
      user.signature = options[:navn]
      user.email = email
      user.confirmed_at = Time.zone.today
      user.addresses = [address('User', options)]
      user.roles = [Role.new]
      user.subscriptions = [subscription(options)] if user_has_a_subscription(options)
      user.subscribe_to_news = options[:Nyhedsbrev]
      user.imported = true
      user.uuid = SecureRandom.uuid
      if user.save
        @succeeded += 1
      else
        @failed << {options: options, user: user.attributes, subscription: user.subscriptions}
      end
    end

    def user_has_a_subscription(options)
      return false if options[:Oprettet].blank?
      return false if options[:Abon_periode].zero?
      options[:Abonnr].present?
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def address(addressable_type, options = {})
      zipp_code         = parse_zipp_code(options)
      city              = parse_city(zipp_code, options)
      Address.new(
        addressable_type: addressable_type,
        name: options[:navn].presence || '-',
        address: options[:adresse].presence || '-',
        zipp_code: zipp_code.presence || '-',
        city: city.presence || 'Danmark'
      )
    end

    def subscription(options)
      Admin::Subscription
        .new(
          subscription_type_id: subscription_type(options).id,
          subscription_id: subscription_id(options),#Admin::Subscription.new_subscription_id,
          start_date: options[:Oprettet],
          end_date: expitation_date(options),
          addresses: [address('Admin::Subscription', options)]
        )
    end

    def expitation_date(options)
      return options[:Oprettet] + 90.days if options[:bestil_abonavis]

      options[:Oprettet] + options[:Abon_periode].to_i.days
    end

    def subscription_id(options = {})
      if Admin::Subscription.exists?(subscription_id: options[:Abonnr])
        return Admin::Subscription.new_subscription_id
      end
      options[:Abonnr]
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

    def subscription_type(options)
      return Admin::SubscriptionType.free_subscription if options[:Friabon]
      return subscription_types(options).first if subscription_types(options).any?

      create_subscription_type(options)
    end

    def subscription_types(options)
      Admin::SubscriptionType
        .where(
          duration: truncate_duration(options),
          internet_version: true,
          print_version: options[:bestil_abonavis],
        )
    end

    def create_subscription_type(options)
      duration = truncate_duration(options)

      Admin::SubscriptionType
        .where(
          title: "Importeret: #{duration.to_s} dage",
          identifier: Admin::SubscriptionType::IMPORTED,
          duration: duration,
          print_version: options[:bestil_abonavis],
          internet_version: true,
          price: price(options)
        )
        .first_or_create
    end

    def truncate_duration(options)
      # return 90 if options[:bestil_abonavis]
      return 7 if options[:Abon_periode] <= 7
      return 30 if options[:Abon_periode] <= 30
      return 90 if options[:Abon_periode] <= 90
      365
    end

    def price(options)
      # return 300 if options[:bestil_abonavis]
      return 20.0 if options[:Abon_periode] <= 7
      return 65.0 if options[:Abon_periode] <= 30
      return 165.0 if options[:Abon_periode] <= 90

      500
    end
  end
end
# rubocop:enable Metrics/ClassLength
