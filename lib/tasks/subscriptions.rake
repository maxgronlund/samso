namespace :subscriptions do
  # usage
  # rake subscriptions:attach_address

  desc 'attach addresses to subscriptions'
  task attach_address: :environment do
    Admin::Subscription.find_each do |subscription|
      next unless subscription.print_version?

      add_address(subscription)
    end
  end

  desc 'attach addresses to subscriptions'
  task remove_addresses: :environment do
    Address.where(addressable_type: 'Admin::Subscription').destroy_all
  end

  def add_address(subscription)
    user = subscription.user
    address_options = user_address_options(user)

    subscription
      .addresses
      .where(address_options)
      .first_or_create(
        address_options
      )
  end

  def user_address_options(user)
    address = user.address
    {
      name: address.name,
      address: address.address,
      zipp_code: address.zipp_code,
      city: address.zipp_code
    }
  end
end
