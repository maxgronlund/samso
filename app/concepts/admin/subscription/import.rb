# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    def initialize
      Admin::Subscription
        .integrated_with_economics.update_all(
          end_date: Time.zone.now - 2.days
        )
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Security/Open
    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        if index.zero?
          #ap unescaped_row
          next
        end

        options = parse_options(unescaped_row)
        options = utf_8_encode(options)
        subscription  = subscription(options)

        if subscription.persisted?
          subscription.update(end_date: Time.zone.now + subscription_type.duration.days)
          next
        end
        user = user(options)
        attach_subscription(user, subscription)

        user.save!
      end
    end
    # rubocop:enable Security/Open

    private

    def attach_subscription(user, subscription)
      return if user.subscriptions.economic_integrated.any?
       user.subscriptions = [subscription]
    end

    def subscription(options = {})
      subscription = Admin::Subscription.find(subscription_id(options))
      subscription.presence || build_subscription(options)
    end

    def build_subscription(options = {})
      Admin::Subscription.new(
        subscription_id: subscription_id(options),
        start_date: Time.zone.now - 10.days,
        end_date: Time.zone.now + subscription_type.duration.days,
        subscription_type_id: subscription_type.id,
        addresses: [address('Admin::Subscription', options)]
      )
    end

    def user(options)
      User.find_by(legacy_subscription_id: subscription_id(options)).presence || build_user(options)
    end

    def build_user(options)
      User
        .new(
          name: options[:name],
          signature: options[:name],
          email: User::Service.fake_email,
          password_digest: User::Service.fake_password,
          legacy_subscription_id: subscription_id(options),
          addresses: [address('User', options)],
          roles: [Role.new]
        )
    end

    def subscription_id(options)
      options[:subscription_id] + '-economic-integration'
    end

    def user_exists?
      user.exists?(legacy_subscription_id: subscription_id(options))
    end

    def subscription_type
      @subscription_type_||= Admin::SubscriptionType.find(admin_system_setup.admin_subscription_type_id)
    end

    def address(addressable_type, options = {})
      Address.new(
        addressable_type: addressable_type,
        name: options[:name],
        address: options[:address],
        zipp_code: options[:zipp_code],
        city: options[:city],
        country: options[:country]
      )
    end

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

    def admin_system_setup
      @admin_system_setup ||= Admin::SystemSetup.find_by(locale: I18n.locale)
    end
  end
end
# rubocop:enable Metrics/ClassLength
