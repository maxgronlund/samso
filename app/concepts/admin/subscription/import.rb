# subscriptions imported from e-conomics

class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    # expire all subscriptions
    def initialize
      @group = ''
    end

    def import(csv_import)
      @name = csv_import[:name]
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        next if index.zero?

        set_options(row)
        expire_subscriptions if index == 1

        user = find_or_initialize_user
        user.persisted? ? update_user_address(user) : save_user(user)

        subscription = find_or_initialize_subscription(user)
        subscription.persisted? ? update_subscription(subscription) : subscription.save!
      end
    end

    def expire_subscriptions
      subscription_type.subscriptions.update_all(end_date: Time.zone.now - 1.days)
    end

    private

    def save_user(user)
      return if user.save!

      Admin::EventNotification.create(
        title: "e-conomics Import - #{@name}",
        body: "Unable to save user: #{user.attributes}",
        message_type: 'economics_import',
        metadata: @options
      )
    end

    def save_subscription(subscription)
      return if subscription.save!

      Admin::EventNotification.create(
        title: "e-conomics Import - #{@name}",
        body: "Unable to save subscription: #{subscription.attributes}",
        message_type: 'economics_import',
        metadata: @options
      )
    end

    def find_or_initialize_subscription(user)
      user.subscriptions.find_by(subscription_id: @options[:subscription_id]) || build_subscription(user)
    end

    def update_subscription(subscription)
      subscription.update(end_date: Time.zone.now + subscription_type.duration.days)
      return if subscription.primary_address.update(address_options)

      Admin::EventNotification.create(
        title: "e-conomics Import - #{@name}",
        body: "Unable to update subscription address: #{subscription.primary_address.attributes}",
        message_type: 'economics_import',
        metadata: address_options
      )
    end

    def build_subscription(user)
      user.subscriptions.new(
        subscription_id: @options[:subscription_id],
        start_date: Time.zone.now,
        end_date: Time.zone.now + subscription_type.duration.days,
        subscription_type_id: subscription_type.id,
        addresses: [new_address('Admin::Subscription')]
      )
    end

    def subscription_type
      Admin::SubscriptionType.find_by(identifier: @options[:group])
    end

    def find_or_initialize_user
      User
        .where(
          user_id: @options[:subscription_id]
        )
        .first_or_initialize(
          user_id: @options[:subscription_id],
          name: @options[:name],
          signature: @options[:name],
          email: User::Service.fake_email,
          password_digest: User::Service.fake_password,
          roles: [Role.new],
          uuid: SecureRandom.uuid,
          addresses: [new_address('User')]
        )
    end

    def update_user_address(user)
      return if user.address.update(address_options)

      Admin::EventNotification.create(
        title: "e-conomics Import - #{@name}",
        body: "Unable to update user address: #{user.attributes}",
        message_type: 'economics_import',
        metadata: address_options
      )
    end

    # build a new address
    def new_address(addressable_type)
      options = address_options
      options[:addressable_type] = addressable_type
      Address.new(options)
    end

    def address_options
      Address::Service.address_options(@options)
    end

    def set_options(row)
      unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
      options = parse_options(unescaped_row)
      @options = utf_8_encode(options)
    end

    def utf_8_encode(options)
      opts = {}
      options.each do |key, value|
        opts[key] = value.force_encoding('ISO-8859-1').encode('UTF-8')
      end
      opts
    end

    def parse_options(row)
      user_fields = Address::Service.user_fields(row[2])
      address_fields = Address::Service.address_fields(row[3])
      {
        group: row[0], # "Gruppe",
        subscription_id: row[1], # "Nr.",
        name: row[2], # "Navn",
        first_name: user_fields[:first_name],
        middle_name: user_fields[:middle_name],
        last_name: user_fields[:last_name],
        address: row[3], # "Adresse 1",
        street_name: address_fields[:street_name],
        house_number: address_fields[:house_number].to_s,
        letter: address_fields[:letter],
        floor: address_fields[:floor],
        side: address_fields[:side],
        zipp_code: row[4], # "Postnr.",
        city: row[5], # "By",
        country: row[6], # "Land",
        phone: row[7], # "Tlf./fax",
        attention: row[8], # "Attention",
        ref_id: row[9], # "Deres ref.",
        email: row[10] # "E-mail"
      }
    end
  end
end
# rubocop:enable Metrics/ClassLength
