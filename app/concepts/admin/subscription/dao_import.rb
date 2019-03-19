# subscriptions imported from e-conomics

# rubocop:disable Metrics/ClassLength
class Admin::Subscription < ApplicationRecord
  require 'csv'
  require 'cgi'
  # services for Admin::CsvImport
  class DaoImport
    # expire all subscriptions
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Security/Open
    # rubocop:disable Metrics/MethodLength
    def import(csv_import)
      csv = open(csv_import.file_url)
      @missing_subscriptions = []
      CSV.parse(csv, headers: false).each_with_index do |row, index|
        next if index.zero?

        unescaped_row = row.map { |i| CGI.unescape(i.to_s) }
        set_options(unescaped_row)
        set_subscription
        if @subscription.nil?
          @missing_subscriptions << { options: @options }
          user = create_user
          next
        end
        set_delivery_address
        set_user
        set_user_address

        update_delivery_address
        update_user_address

        # ap '------------------'
      end
      if @missing_subscriptions.any?
        ap '------------------------------'
        ap 'FAILED TO CREATE USERS'
        ap '------------------------------'
        ap @missing_subscriptions
      end
    end
    # rubocop:enable Security/Open
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    private

    def create_user
      user =
        User.new(
          name: full_name.presence || '-',
          addresses: [new_address('User')],
          roles: [Role.new],
          uuid: SecureRandom.uuid,
          imported: true,
          uuid: SecureRandom.uuid,
          email: User::Service.fake_email,
          password_digest: User::Service.fake_password,
          subscriptions: [new_subscription]
        )
      unless user.save!
        @missing_subscriptions << @options
      end
    end

    def full_name
      [@options[:fornavn], @options[:mellemnavn], @options[:efternavn]].join(' ')
    end

    def new_subscription
      subscription =
        Admin::Subscription.new(
          subscription_id: @options[:abonr],
          subscription_type_id: Admin::SubscriptionType.from_economics.id,
          start_date: Time.zone.now,
          end_date: Time.zone.now + 1000.years,
          addresses: [new_address('Admin::Subscription')]
        )
    end

    def new_address(addressable_type)
      Address.new(
        addressable_type: addressable_type,
        address: @options[:adresse].presence || '',
        name: @options[:fornavn].presence || '-',
        first_name: @options[:fornavn].presence || '-',
        middle_name: @options[:mellemnavn],
        last_name: @options[:efternavn].presence || '-',
        street_name: @options[:vejnavn],
        house_number: @options[:husnr],
        letter: @options[:litra],
        floor: @options[:sal],
        side: @options[:side],
        zipp_code: @options[:postnr],
        city: @options[:bynavn],
        country: @options[:land]
      )
    end

    def set_subscription
      @subscription = Admin::Subscription.find_by(subscription_id: @options[:abonr])
    end

    def set_delivery_address
      @delivery_address = @subscription.delivery_address
    end

    def set_user
      @user = @subscription.user
    end

    def set_user_address
      @user_address = @user.address
    end

    def update_delivery_address
      update_address(@delivery_address)
    end

    def update_subscription_address
      subscription_address = @subscription.primary_address
      return if subscription_address.id == @delivery_address.id

      update_address(subscription_address)
    end

    def update_user_address
      update_address(@user_address) if delivery_address_is_user_address?
    end

    def update_address(address)
      address
        .update(
          first_name: @options[:fornavn],
          middle_name: @options[:mellemnavn],
          last_name: @options[:efternavn],
          street_name: @options[:vejnavn],
          house_number: @options[:husnr],
          letter: @options[:litra],
          zipp_code: @options[:postnr],
          city: @options[:bynavn],
          floor: @options[:sal],
          side: @options[:side]
        )
    end

    def set_temporary_subscription_address
      @temporary_user_address = @user.primary_address
    end

    def delivery_address_is_user_address?
      return false unless @user_address.address.include?(@delivery_address.street_name)
      return false unless @user_address.address.include?(@delivery_address.house_number.to_s)

      true
    end

    def utf_8_encode(options)
      opts = {}
      options.each do |key, value|
        opts[key] = value.force_encoding('ISO-8859-1').encode('UTF-8')
      end
      opts
    end

    def set_options(row)
      @options = {
        gruppe: row[0],
        abonr: row[1],
        fornavn: row[2],
        mellemnavn: row[3],
        efternavn: row[4],
        attention: row[5],
        kontaktperson: row[6],
        vejnavn: row[7],
        husnr: row[8],
        litra: row[9],
        sal: row[10],
        side: row[11],
        postnr: row[12],
        bynavn: row[13],
        land: row[14],
        antalaviser: row[15],
        co: row[16],
        tiltaleform: row[17],
        gadeident: row[18],
        david: row[19]
      }
    end
  end
end
# rubocop:enable Metrics/ClassLength
