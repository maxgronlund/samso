# Persist knowledge of users
module KnowSubscriptionHelper
  def create_valid_subscription_for(user, subscription_type)
    FactoryBot
      .create(
        :subscription,
        subscription_id: Admin::Subscription.new_subscription_id,
        user_id: user.id,
        subscription_type_id: subscription_type.id
      )
  end

  def create_expired_subscription_for(user, subscription_type)
    FactoryBot
      .create(
        :subscription,
        subscription_id: Admin::Subscription.new_subscription_id,
        user_id: user.id,
        subscription_type_id: subscription_type.id,
        start_date: Time.zone.now.to_datetime - 500.days,
        end_date: Time.zone.now.to_datetime - 410.days
      )
  end
end

World(KnowSubscriptionHelper)
