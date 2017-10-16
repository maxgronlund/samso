Given('the basic pages are build') do
  # super_user = FactoryGirl.create(:user, name: 'super_user')
  ap FactoryGirl
    .create(
      :page,
      user_id: super_user.id
    )
end
