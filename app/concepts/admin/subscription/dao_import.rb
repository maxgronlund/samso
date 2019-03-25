# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class DaoImport
    # expire all subscriptions
    # rubocop:disable Security/Open
    def import(csv_import)
      @name = csv_import[:name]
      csv = open(csv_import.file_url)
      @missing_subscriptions = []
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        next if index.zero?

        prepare(row)
        user = import_user
        import_subscription(user) if user.present?
      end
    end
    # rubocop:enable Security/Open

    private

    def prepare(row)
      @subscription = nil
      set_options(row)
    end

    def import_user
      user = find_or_initialize_user
      user.persisted? ? update_user_address(user) : user.save!
      user
    rescue => e
      Admin::EventNotification.create(
        title: "DAO Import - #{@name}",
        body: e.message,
        message_type: 'dao_import',
        metadata: @options
      )
      nil
    end

    def find_or_initialize_user
      return subscription.user if user_exists?

      User
        .new(
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

    def user_exists?
      subscription.present? && subscription.user.present?
    end

    def import_subscription(user)
      find_or_initialize_subscription(user)
      @subscription.persisted? ? update_subscription_address : @subscription.save!
    end

    def find_or_initialize_subscription(user)
      subscription.presence || build_subscription(user)
    end

    def build_subscription(user)
      @subscription =
        user.subscriptions.new(
          subscription_id: @options[:subscription_id],
          start_date: Time.zone.now,
          end_date: Time.zone.now + subscription_type.duration.days,
          subscription_type_id: subscription_type.id,
          addresses: [new_address('Admin::Subscription')]
        )
    end

    def subscription_type
      Admin::SubscriptionType.dao_imported
    end

    def subscription
      @subscription ||= Admin::Subscription.find(@options[:subscription_id])
    end

    def new_address(addressable_type)
      options = Address::Service.address_options(@options)
      options[:addressable_type] = addressable_type
      Address.new(options)
    end

    def address_options
      Address::Service.address_options(@options)
    end

    def update_subscription_address
      ap 'update_subscription_address'
      ap subscription_address_is_temporary?
      if subscription_address_is_temporary?
        update_temporary_address
      else
        subscription.address.update(address_options)
      end
    end

    def update_user_address(user)
      user.address.update(address_options)
    end

    def update_address(address)
      address.update(address_options)
    end

    def subscription_address_is_temporary?
      address = subscription.primary_address
      !same_address?(address)
    end

    def same_address?(address)
      street_name = address.street_name
      house_number = address.house_number.to_s
      (@options[:house_number] == house_number) && (@options[:street_name] = street_name)
    end

    def update_temporary_address
      if subscription.temporary_address.present?
        subscription.temporary_address.update(address_options)
        return
      end
      create_temporary_subscription_address
    end

    def create_temporary_subscription_address
      options = {
        address_type: Address::TEMPORARY_ADDRESS,
        start_date: Time.zone.today,
        end_date: Time.zone.today + 365.days
      }
      options.merge!(address_options)
      subscription.addresses.create(options)
    end

    def utf_8_encode(options)
      opts = {}
      options.each do |key, value|
        opts[key] = value.force_encoding('ISO-8859-1').encode('UTF-8')
      end
      opts
    end

    def set_options(row)
      unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
      options = parse_options(unescaped_row)
      @options = utf_8_encode(options)
      @options[:name] = full_name
      @options[:last_name] = 'NA' if @options[:last_name].blank?
    end

    def parse_options(row)
      {
        gruppe: row[0],
        subscription_id: row[1],
        first_name: row[2],
        middle_name: row[3],
        last_name: row[4],
        attention: row[5],
        kontaktperson: row[6],
        street_name: row[7],
        house_number: row[8],
        letter: row[9],
        sal: row[10],
        side: row[11],
        zipp_code: row[12],
        city: row[13],
        country: row[14],
        antalaviser: row[15],
        co: row[16],
        tiltaleform: row[17],
        gadeident: row[18],
        david: row[19]
      }
    end

    def full_name
      User::Service.full_name(@options)
    end
  end
end
# rubocop:enable Metrics/ClassLength
