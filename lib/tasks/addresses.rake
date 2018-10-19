namespace :addresses do
  # usage
  # rake blog_posts:update_layout
  desc 'import addresses from esisting users'
  task import: :environment do
    ap 'import addresses'
    User.find_each do |user|
      import_address(user) unless user.postal_code_and_city.blank?
    end
  end

  def import_address(user)
    #return if user.addresses.any?
    postal_code_and_city = user.postal_code_and_city.split
    address =
      Address
      .where(user_id: user.id)
      .first_or_initialize(
        user_id: user.id,
      )
      address
        .update(
          name: user.name,
          address: user.address,
          zipp_code: postal_code_and_city.first.to_i,
          city: postal_code_and_city.last
        )
  end
end
