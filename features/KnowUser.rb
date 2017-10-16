module KnowUsersHelper
  def super_user
    @super_user ||=
      FactoryGirl.create(
        :user,
        name: 'super_user',
        email: 'super_user@example.com'
      )
  end
end

World(KnowUsersHelper)
