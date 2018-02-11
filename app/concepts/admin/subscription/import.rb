# namespace to confine service class to Admin:BlogPost::Import
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

    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        next if index.zero?
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        options = build_options(unescaped_row)
        user = find_or_initialize_user(options)
        user = create_user(options) if user.nil?
        create_subscription(user)
      end
    end

    private

    def build_options(row)
      {
        abonr: row[0],
        fornavn: row[1],
        mellemnavn: row[2],
        efternavn: row[3],
        attention: row[4],
        kontaktperson: row[5],
        vejnavn: row[6],
        husnr: row[7],
        litra: row[8],
        sal: row[9],
        side: row[10],
        postnr: row[11],
        bynavn: row[12],
        land: row[13],
        antalaviser: row[14],
        co: row[15],
        tiltaleform: row[16],
        gadeident: row[17],
        david: row[18]
      }
    end

    def find_or_initialize_user(options = {})
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

    def build_user_address(options = {})
      address = options[:vejnavn]
      address += " #{options[:husnr]}" unless options[:husnr].empty?
      address += ".#{options[:litra]}" unless options[:litra].empty?
      address += ", #{options[:sal]}" unless options[:sal].empty?
      address += ".#{options[:side]}" unless options[:side].empty?
      address
    end

    def build_postal_code_and_city(options = {})
      postal_code_and_city = options[:postnr]
      postal_code_and_city = " #{options[:bynavn]}"
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
