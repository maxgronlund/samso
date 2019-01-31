# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    def initialize
      @subscribed_user_ids = []
      @imported_subscription_type = Admin::SubscriptionType.imported
      @imported_subscription_type
        .subscriptions
        .destroy_all
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Security/Open
    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        if index.zero?
          ap unescaped_row
          next
        end

        options = parse_options(unescaped_row)
        options = utf_8_encode(options)
        user = find_or_create_user(options)
        set_user_address(user, options)
        set_subscription_type(options)
        subscription = parse_subscription(user, options)
        next if subscription.nil?


        # next
        # options = build_options(unescaped_row)
        # next if options[:abonr].nil? || options[:abonr].empty?

        # user = find_user_by_legacy_subscription_id(options)
        # user = create_user(options) if user.nil?
        # create_subscription(user, options)
      end
    end
    # rubocop:enable Security/Open

    private

    def utf_8_encode(options)
      opts = {}
      options.each do |key, value|
        opts[key] = value.force_encoding('ISO-8859-1').encode('UTF-8')
      end
      opts
    end

    def parse_options(row)
      {
        group: row[0], # "Gruppe",
        subscription_id: row[1], # "Nr.",
        name: row[2], # "Navn",
        address: row[3], # "Adresse 1",
        zipp_code: row[4], # "Postnr.",
        city: row[5], # "By",
        country: row[6], # "Land",
        phone: row[7], # "Tlf./fax",
        attention: row[8], # "Attention",
        ref_id: row[9], # "Deres ref.",
        email: row[10] # "E-mail"
      }
    end

    def set_subscription_type(options)
      @subscription_type ||=
        Admin::SubscriptionType
        .where(
          title: options[:group],
          identifier: 'economic-integration'
        ).first_or_create(
          title: options[:group],
          body: 'Importeret fra economics',
          internet_version: true,
          print_version: true,
          locale: 'da',
          active: false,
          free: false,
          identifier: 'economic-integration',
        )
    end

    def find_or_create_user(options)
      return find_or_create_user_by_email(options) if options[:email].valid_email?
      find_or_create_user_by_subscription_id(options)
    end

    def fake_email(options)
      options[:name].strip.tr(' ', '-').downcase + User::FAKE_EMAIL
    end

    def find_or_create_user_by_email(options)
      User
        .where(email: options[:email])
        .first_or_create!(
          email: options[:email],
          password: User::FAKE_PASSWORD,
          name: options[:name],
          signature: options[:name],
          legacy_subscription_id: subscription_id(options)
        )
    end

    def find_or_create_user_by_subscription_id(options)
      id = subscription_id(options)
      User
        .where(legacy_subscription_id: id)
        .first_or_create!(
          legacy_subscription_id: id,
          email: fake_email(options),
          password: User::FAKE_PASSWORD,
          name: options[:name],
          signature: options[:name]
        )
    end

    def set_user_address(user, options)
      address = user.address
      set_address(address, options)
    end

    def parse_subscription(user, options)
      return nil if options[:subscription_id].blank?
      id = subscription_id(options)
      user
        .subscriptions
        .where(subscription_id: id)
        .first_or_create!(
          subscription_id: id,
          subscription_type_id: @subscription_type.id
        )
    end

    def set_subscription_address(subscription, options)
      address = subscription_address(subscription)
      set_address(address, options)
    end

    def set_address(address, options)
      address.name = options[:name] unless options[:name].blank?
      address.address = options[:address] unless options[:address].blank?
      address.zipp_code = options[:zipp_code] unless options[:zipp_code].blank?
      address.city = options[:city] unless options[:city].blank?
      address.country = options[:country] unless options[:country].blank?
      address.save
    end

    def subscription_address(subscription)
      subscription.primary_address.presence || subscription.addresses.new(address_type: Address::PRIMARY_ADDRESS)
    end

    def subscription_id(options)
      options[:subscription_id] + '-economic-integration'
    end


    # rubocop:disable Metrics/MethodLength
    # def build_options(row)
    #   {
    #     abonr: row[0].strip,
    #     fornavn: row[1].strip,
    #     mellemnavn: row[2].strip,
    #     efternavn: row[3].strip,
    #     attention: row[4].strip,
    #     kontaktperson: row[5].strip,
    #     vejnavn: row[6].strip,
    #     husnr: row[7],
    #     litra: row[8].strip,
    #     sal: row[9],
    #     side: row[10],
    #     postnr: row[11],
    #     bynavn: row[12].strip,
    #     land: row[13].strip,
    #     antalaviser: row[14],
    #     co: row[15].strip,
    #     tiltaleform: row[16].strip,
    #     gadeident: row[17].strip,
    #     david: row[18]
    #   }
    # end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    # def find_user_by_legacy_subscription_id(options = {})
    #   User.find_by(legacy_subscription_id: options[:abonr])
    # end

    # def create_user(options = {})
    #   options = new_user_options(options)
    #   user = User.new(options)
    #   user.save(validate: false)
    #   user
    # end

    # def new_user_options(options = {})
    #   user_name = build_user_name(options)
    #   address = build_user_address(options)
    #   postal_code_and_city = build_postal_code_and_city(options)
    #   {
    #     name: user_name,
    #     signature: user_name,
    #     legacy_subscription_id: options[:abonr],
    #     address: address,
    #     postal_code_and_city: postal_code_and_city,
    #     email: fake_email,
    #     free_subscription: false
    #   }
    # end

    # def build_user_name(options = {})
    #   name = options[:fornavn]
    #   name += " #{options[:mellemnavn]}" unless options[:mellemnavn].empty?
    #   name += " #{options[:efternavn]}" unless options[:efternavn].empty?
    #   name
    # end

    # # rubocop:disable Metrics/AbcSize
    # def build_user_address(options = {})
    #   address = options[:vejnavn]
    #   address += " #{options[:husnr]}" unless options[:husnr].empty?
    #   address += ".#{options[:litra]}" unless options[:litra].empty?
    #   address += ", #{options[:sal]}" unless options[:sal].empty?
    #   address += ".#{options[:side]}" unless options[:side].empty?
    #   address
    # end
    # # rubocop:enable Metrics/AbcSize

    # def build_postal_code_and_city(options = {})
    #   postal_code_and_city = options[:postnr]
    #   postal_code_and_city += " #{options[:bynavn]}" unless options[:bynavn].empty?
    #   postal_code_and_city
    # end

    # def fake_email
    #   SecureRandom.uuid + User::FAKE_EMAIL
    # end

    # def create_subscription(user, options = {})
    #   options = subscription_options(user, options)
    #   @imported_subscription_type
    #     .subscriptions
    #     .create(options)
    # end

    # def subscription_options(user, options = {})
    #   {
    #     user_id: user.id,
    #     start_date: Time.zone.now,
    #     end_date: Time.zone.now + 3.month,
    #     subscription_id: options[:abonr]
    #   }
    # end
  end
end
# rubocop:enable Metrics/ClassLength
