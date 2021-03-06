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

      @name = csv_import[:name]
      @succeeded = 0
      @subscriptions_updated = 0
      @new_subscriptions = 0
      @users_udated = 0
      @failed = 0
      @moved_subscriptions = {}
      csv_file = open(csv_import.file_url)
      CSV.parse(csv_file, headers: false).each do |row|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = parsed_row(unescaped_row)
        import_user(options)
        # move_subscriptions(options)
        # import_missing_users(options)
      end

      log_user_import
      log_moved_subscription
    end
    # rubocop:enable Security/Open

    private

    # for some reason some users do not exist
    # import unless a user with the same email of user_id exists
    def import_missing_users(options)
      return if options[:email].include?(FAKE_EMAIL)
      return if User.find_by(email: options[:email]).present?
      return if User.find_by(user_id: options[:Abonnr]).present?
      import_user(options)
    end

    # in the old system two users with the same email was possible
    # when the import encounter an user with an existing email
    # that users subscriptions are added the first users account
    # and a notification is added
    def move_subscriptions(options)
      return if options[:email].include?(FAKE_EMAIL)
      first_user = User.find_by(email: options[:email])
      return if first_user.nil?
      return if options[:UdloebsDato].nil?
      return if options[:UdloebsDato] < Time.zone.now

      subscription_to_move = new_subscription(options)
      # return if subscription_to_move.expired?
      # return unless subscription_exists?(subscription_to_move, first_user)
      return

      subscription_to_move.user_id = first_user.id
      # subscription_to_move.save!


      @moved_subscriptions["#{first_user.id} ----------------------".to_sym] = first_user.id
      @moved_subscriptions["moved_to_user_#{first_user.id}".to_sym] = first_user.email
      # @moved_subscriptions["moved_subscription_#{subscription_to_move.id}".to_sym] = subscription_to_move.id

    end

    def subscription_exists?(subscription_to_move, first_user)
      first_user.subscriptions.each do |existing_subscription|
        return false  if subscription_to_move.start_date != existing_subscription.start_date
        return false  if subscription_to_move.end_date != existing_subscription.end_date
        return false  if subscription_to_move.subscription_type_id != existing_subscription.subscription_type_id
      end
      true
    end

    def log_moved_subscription
      Admin::EventNotification.create(
        title: "Moved Subscription",
        body: "CSV file: #{@name}",
        message_type: 'user_import',
        metadata: @moved_subscriptions
      )
    end


    def password(options={})
      options[:password].nil? ? User::Service.fake_password : options[:password]
    end

    def log_user_import
      metadata = {
        new_users_sucessfully_imported: @succeeded,
        failed_imports: @failed,
        users_updated: @users_udated,
        subscriptions_updated: @subscriptions_updated
      }
      Admin::EventNotification.create(
        title: "STATUS User Import ",
        body: "CSV file: #{@name}",
        message_type: 'user_import',
        metadata: metadata
      )
    end

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/CyclomaticComplexity
    def parsed_row(row)
      {
        user_id: row[A].empty? ? nil : row[A].to_i,
        Abonnr: row[B].empty? ? nil : row[B].to_i,
        navn: row[C].strip.downcase.titleize,
        adresse: row[D].strip.downcase.titleize,
        Stednavn: row[E].empty? ? nil : row[E].strip.downcase.titleize,
        postnr_by: row[F].empty? ? nil : row[F].strip.downcase.titleize,
        Telefon: row[G].empty? ? nil : row[G].strip.downcase,
        Mobil: row[H].empty? ? nil : row[H].strip.downcase,
        Nyhedsbrev: row[I] == '1',
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
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity

    def import_user(options = {})

      # if a user with the email alread exsts
      user = User.find_by(email: options[:email])
      if user.present?
        # move subscriptions from the csv file into the existing user
        move_subscriptions(options)
        return
      end

      # there might be users with a Abbnr/user_id already importer
      user = find_or_initialize_user(options)
      if user.persisted?
        if user.update(
            subscribe_to_news: options[:Nyhedsbrev],
            email: options[:email],
            password: password(options),
            confirmed_at: Time.zone.today
          )
          @users_udated += 1
          # make sure subscriptions are moved
          move_subscriptions(options)
        else
          error_message(options, user)
        end
        return # we do not need to do anything more
      end

      # the user do not exist so set the info from the csv file to the new user
      User::Service.set_password(user, options[:password])
      user.confirmed_at = Time.zone.now
      user.name = options[:navn].presence || '-'
      user.signature = options[:navn]
      user.email = options[:email]
      user.confirmed_at = Time.zone.today
      user.addresses = [address('User', options)]
      user.roles = [Role.new]
      user.subscriptions = [new_subscription(options)] if valid_subscription_options?(options)
      user.subscribe_to_news = options[:Nyhedsbrev]
      user.imported = true
      user.uuid = SecureRandom.uuid
      user.user_id = User.new_user_id if user.user_id.blank? # create a new id
      if user.save
        @succeeded += 1
      else
        @failed =+ 1
        error_message(options, user)
      end
    end

    def error_message(options, user)
      metadata = { row: '========================' }
        metadata.merge!(options)
        metadata.merge!(user_attributes: '========================')
        metadata.merge!(user.attributes)
        # metadata.merge!(user_address: '========================')
        # metadata.merge!(user.address.attributes)
        metadata.merge!(error_message: '========================')
        metadata.merge!(message: user.errors.full_messages)
        user.subscriptions.each do |subscription|
          metadata
            .merge!(subscription_attributes: '========================')
            .merge!(subscription.attributes)
        end
        Admin::EventNotification.create(
          title: "ERROR! USER Import",
          body: 'Unable to save user',
          message_type: 'user_import',
          metadata: metadata
        )
    end

    def find_or_initialize_user(options)
      return User.new(user_id: User.new_user_id) if options[:Abonnr].blank? # if there is no user_id
      User.where(user_id: options[:Abonnr]).first_or_initialize
    end

    def email_is_real?(options)
      return false if options[:email].blank?
      return false if options[:email].include?(User::FAKE_EMAIL)

      true
    end

    def extend_subscription(options, user)
      subbsctiption_to_extend = subbsctiption_to_extend(options, user)
      if subbsctiption_to_extend.present?
        if subbsctiption_to_extend.update(end_date: options[:UdloebsDato])
          @subscriptions_updated += 1
        end
      else
        user.subscriptions = [new_subscription(options)]
        user.save
      end
    end

    def subbsctiption_to_extend(options, user)
      subscription = Admin::Subscription.find(options[:Abonnr])
      return subscription if subscription.present?
      return user.subscriptions.last if user.subscriptions.any?

      nil
    end

    def valid_subscription_options?(options)
      return false if options[:Oprettet].blank?
      return false if options[:Abon_periode].zero?

      # options[:Abonnr].present?
      true
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def address(addressable_type, options = {})
      zipp_code = parse_zipp_code(options)
      city = parse_city(zipp_code, options)
      address_fields = Address::Service.address_fields(options[:adresse])
      user_fields =  Address::Service.user_fields(options[:navn])

      Address.new(
        address: options[:adresse].presence || '-',
        addressable_type: addressable_type,
        name: options[:navn].presence || '-',
        first_name: user_fields[:first_name].presence || '-',
        middle_name: user_fields[:middle_name],
        last_name: user_fields[:last_name].presence || '-',
        street_name: address_fields[:street_name].presence || '-',
        house_number: address_fields[:house_number],
        letter: address_fields[:letter],
        floor: address_fields[:floor],
        side: address_fields[:side],
        zipp_code: zipp_code.presence || '-',
        city: city.presence || '-',
        country: address_fields[:country]
      )
    end

    def new_subscription(options)
      @new_subscriptions += 1
      Admin::Subscription
        .new(
          subscription_type_id: subscription_type(options).id,
          subscription_id: subscription_id(options),
          start_date: options[:Oprettet],
          end_date: options[:UdloebsDato],
          addresses: [address('Admin::Subscription', options)]
        )
    end

    def expitation_date(options)
      return options[:Oprettet] + 90.days if options[:bestil_abonavis]

      options[:Oprettet] + options[:Abon_periode].to_i.days
    end

    def subscription_id(options = {})
      return Admin::Subscription.new_subscription_id if Admin::Subscription.exists?(subscription_id: options[:Abonnr])
      return Admin::Subscription.new_subscription_id if options[:Abonnr].blank?

      options[:Abonnr]
    end

    def parse_zipp_code(options = {})
      zipp = options[:postnr_by].to_i
      return zipp.to_s unless zipp.zero?

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
      return Admin::SubscriptionType.find_by(identifier: Admin::SubscriptionType::FREE) if options[:Friabon]
      return subscription_types(options).first if subscription_types(options).any?

      create_subscription_type(options)
    end

    def subscription_types(options)
      Admin::SubscriptionType
        .where(
          duration: truncate_duration(options),
          internet_version: true,
          print_version: options[:bestil_abonavis]
        )
    end

    def create_subscription_type(options)
      duration = truncate_duration(options)

      Admin::SubscriptionType
        .where(
          title: "Importeret: #{duration} dage",
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
