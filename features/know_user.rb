module KnowUsersHelper
  def super_user
    @super_user ||=
      FactoryGirl
      .create(
        :user,
        name: 'super_user',
        email: 'super_user@example.com',
        password: 'SesamSesamOpenUp',
        confirmed_at: Time.zone.now
      )
  end

  def member(email = 'member', password = 'ComeOnIn123')
    @member ||=
      FactoryGirl
      .create(
        :user,
        name: 'member',
        email: email,
        password: password,
        confirmed_at: Time.zone.now
      )
  end

  def unconfirmed_user
    @unconfirmed_user ||=
      FactoryGirl
      .create(
        :user,
        name: 'unconfirmed_user',
        email: 'unconfirmed_user@example.com',
        password: 'ComeOnLetMeIn',
        confirmation_token: 'c1af8d4a2b41a1f25c93d0c9cda4243ed85bb059f09e99056d5f81fb091b3c94',
        confirmation_sent_at: Time.zone.now
      )
  end
end

World(KnowUsersHelper)
