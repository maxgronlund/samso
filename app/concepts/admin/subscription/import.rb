# namespace to confine service class to Admin:BlogPost::Import
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
        next if index.zero?

        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }

        ap unescaped_row
        next
        options = build_options(unescaped_row)
        next if options[:abonr].nil? || options[:abonr].empty?

        user = find_user_by_legacy_subscription_id(options)
        user = create_user(options) if user.nil?
        create_subscription(user, options)
      end
    end
    # rubocop:enable Security/Open

    private

    # rubocop:disable Metrics/MethodLength
    def build_options(row)
      {
        abonr: row[0].strip,
        fornavn: row[1].strip,
        mellemnavn: row[2].strip,
        efternavn: row[3].strip,
        attention: row[4].strip,
        kontaktperson: row[5].strip,
        vejnavn: row[6].strip,
        husnr: row[7],
        litra: row[8].strip,
        sal: row[9],
        side: row[10],
        postnr: row[11],
        bynavn: row[12].strip,
        land: row[13].strip,
        antalaviser: row[14],
        co: row[15].strip,
        tiltaleform: row[16].strip,
        gadeident: row[17].strip,
        david: row[18]
      }
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    def find_user_by_legacy_subscription_id(options = {})
      User.find_by(legacy_subscription_id: options[:abonr])
    end

    def create_user(options = {})
      options = new_user_options(options)
      user = User.new(options)
      user.save(validate: false)
      user
    end

    def new_user_options(options = {})
      user_name = build_user_name(options)
      address = build_user_address(options)
      postal_code_and_city = build_postal_code_and_city(options)
      {
        name: user_name,
        signature: user_name,
        legacy_subscription_id: options[:abonr],
        address: address,
        postal_code_and_city: postal_code_and_city,
        email: fake_email,
        free_subscription: false
      }
    end

    def build_user_name(options = {})
      name = options[:fornavn]
      name += " #{options[:mellemnavn]}" unless options[:mellemnavn].empty?
      name += " #{options[:efternavn]}" unless options[:efternavn].empty?
      name
    end

    # rubocop:disable Metrics/AbcSize
    def build_user_address(options = {})
      address = options[:vejnavn]
      address += " #{options[:husnr]}" unless options[:husnr].empty?
      address += ".#{options[:litra]}" unless options[:litra].empty?
      address += ", #{options[:sal]}" unless options[:sal].empty?
      address += ".#{options[:side]}" unless options[:side].empty?
      address
    end
    # rubocop:enable Metrics/AbcSize

    def build_postal_code_and_city(options = {})
      postal_code_and_city = options[:postnr]
      postal_code_and_city += " #{options[:bynavn]}" unless options[:bynavn].empty?
      postal_code_and_city
    end

    def fake_email
      SecureRandom.uuid + User::FAKE_EMAIL
    end

    def create_subscription(user, options = {})
      options = subscription_options(user, options)
      @imported_subscription_type
        .subscriptions
        .create(options)
    end

    def subscription_options(user, options = {})
      {
        user_id: user.id,
        start_date: Time.zone.now,
        end_date: Time.zone.now + 3.month,
        subscription_id: options[:abonr]
      }
    end
  end
end
# rubocop:enable Metrics/ClassLength
