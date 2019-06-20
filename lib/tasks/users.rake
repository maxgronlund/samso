namespace :users do
  desc 'add uuid'
  task add_uuid: :environment do
    User.find_each do |user|
      user.update(uuid: SecureRandom.uuid) if user.uuid.blank?
    end
  end

  desc 'delete dublets'
  task delete_dublets: :environment do
    User.find_each do |user|
      users = User.where(user_id: user.user_id)
      if users.count > 1
        users.each_with_index do |user_to_delete, index|
          user_to_delete.destroy unless index.zero?
        end
      end
    end
  end

  desc 'reset user_ids'
  task reset_ids: :environment do
    User
      .where(user_id: nil)
      .update_all(user_id: User.new_user_id)
  end

  # usage
  # rake users:remove_non_editors
  desc 'remove all non editors'
  task remove_non_editors: :environment do
    User.find_each do |user|
      user.destroy unless user.editor?
    end

    Admin::CsvImport
    .where(import_type: ['User', 'Admin::Subscription', 'Admin::Subscription::DaoImport'])
    .update_all(imported: nil)
  end

  # usage
  # rake users:remove_not_from_economics
  desc 'remove all users not imported from economics'
  task remove_not_from_economics: :environment do
    subscription_type_ids =
      Admin::SubscriptionType.where(identifier: ["Abonnement", "AB-EAN", "FriAbb"]).pluck(:id)

    User.find_each do |user|
      next if user.editor?

      destroy_user = true
      user.subscriptions.each do |subscription|
        destroy_user = false if subscription_type_ids.include?(subscription.subscription_type_id)
      end
      user.destroy if destroy_user
    end
  end

  # usage
  # rake users:update_latest_online_payments
  desc 'update when the latest online payment was created'
  task update_latest_online_payments: :environment do
    Payment.order(:created_at).each do |payment|
      next unless payment.accepted? && payment.user.present?

      payment.user.update(latest_online_payment: payment.created_at)
    end
  end
end
