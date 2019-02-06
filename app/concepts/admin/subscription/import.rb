# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class Import
    # expire all subscriptions
    def initialize
      Admin::Subscription.economic_integrated.update_all(end_date: Time.zone.now - 1.days)
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Security/Open
    def import(csv_import)
      csv = open(csv_import.file_url)
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        if index.zero?
          #ap unescaped_row
          # dont use the top row
          next
        end

        options = parse_options(unescaped_row)
        @options = utf_8_encode(options)
        ap @subscription  = get_subscription

        if @subscription.persisted?
          extend_subscription
          next
        end
        user = build_user
        user.subscriptions = [@subscription]
        #attach_subscription(user)
        ap user
        user.save!
      end
    end
    # rubocop:enable Security/Open

    private

    # def attach_subscription(user)
    #   return if user.subscriptions.economic_integrated.any?
    #   user.subscriptions = [@subscription]
    # end

    def get_subscription
      Admin::Subscription.find(@options[:subscription_id]) || build_subscription
    end

    def extend_subscription
      @subscription.update(end_date: Time.zone.now + subscription_type.duration.days)
    end

    # return the user if the user is a in the system, other wise build a new one 
    # def get_user
      # subscription.present? ? subscription.user : build_user
    # end

    def build_subscription
      Admin::Subscription.new(
        subscription_id: @options[:subscription_id],
        start_date: Time.zone.now,
        end_date: Time.zone.now + subscription_type.duration.days,
        subscription_type_id: Admin::SubscriptionType.imported.id,
        addresses: [address('Admin::Subscription')]
      )
    end

    def build_user
      User
        .new(
          name: @options[:name],
          signature: @options[:name],
          email: User::Service.fake_email,
          password_digest: User::Service.fake_password,
          roles: [Role.new]
        )
    end

    # the default subscription type for economics
    def subscription_type
      @subscription_type ||= Admin::SubscriptionType.imported
    end

    # build a new address
    def address(addressable_type)
      Address.new(
        addressable_type: addressable_type,
        name: @options[:name].presence || 'No Name',
        address: @options[:address].presence || 'NA',
        zipp_code: @options[:zipp_code].presence || 'NA',
        city: @options[:city].presence || '',
        country: @options[:country].presence || 'Danmark',
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
