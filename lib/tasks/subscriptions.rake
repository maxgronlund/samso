namespace :subscriptions do
  # usage
  # rake subscriptions:add_addresses

  desc 'attach addresses to printed subscriptions'
  task add_addresses: :environment do
    Admin::Subscription.find_each do |subscription|
      next unless subscription.print_version?
      add_addres(subscription)
    end
  end

  def add_addres(subscription)
    user = subscription.user
    address = user_address(user)
    return if address.blank?
    address =
      user
      .addresses
      .first_or_create(
        address: address.address,
        zipp_code: address.zipp_code,
        city: address.city,
        address_type: Address::SUBSCRIPTION_ADDRESS
      )
    subscription
      .subscription_addresses
      .first_or_create(
        address_id: address.id,
        start_date: subscription.start_date,
        end_date: subscription.end_date
      )
  end

  def user_address(user)
    user&.addresses&.user_address
  end
end
