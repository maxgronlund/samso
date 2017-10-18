# Persist knowledge of users
module KnowSubscriptionTypeHelper
  def internet_subscription_type(title)
    @internet_subscription_type ||=
      FactoryGirl
      .create(
        :subscription_type,
        title: title,
        internet_version: true,
        print_version: false
      )
  end

  def print_subscription_type(title)
    @print_subscription_type ||=
      FactoryGirl
      .create(
        :subscription_type,
        title: title,
        internet_version: true,
        print_version: true
      )
  end
end

World(KnowSubscriptionTypeHelper)
