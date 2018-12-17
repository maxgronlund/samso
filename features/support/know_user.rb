# Persist knowledge of users
module KnowUserHelper
  # rubocop:disable Metrics/MethodLength
  def create_user(options = {})
    user_name            = options[:name] || Faker::Name.name
    email                = options[:email] || Faker::Internet.safe_email
    password             = options[:password] || Faker::Internet.password
    confirmation_token   = options[:confirmation_token]
    confirmation_sent_at = options[:confirmation_sent_at]
    confirmed_at         = options[:confirmed_at]

    user =
      FactoryBot
      .create(
        :user,
        name: user_name,
        email: email,
        password: password,
        confirmation_token: confirmation_token,
        confirmation_sent_at: confirmation_sent_at,
        confirmed_at: confirmed_at # Time.zone.now
      )
    create_role(user, options)
    user
  end
  # rubocop:enable Metrics/MethodLength

  def create_role(user, options = {})
    permission = options[:permission] || Role::MEMBER
    FactoryBot
      .create(:role, permission: permission, user_id: user.id)

    return unless permission == Role::SUPER_ADMIN

    FactoryBot
      .create(:role, permission: permission, user_id: user.id)
  end
end

World(KnowUserHelper)
