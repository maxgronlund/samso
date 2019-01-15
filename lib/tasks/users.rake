namespace :users do
  desc 'delete dublets'
  task delete_dublets: :environment do
    User.find_each do |user|
      users = User.where(legacy_id: user.legacy_id)
      if users.count > 1
        users.each_with_index do |user_to_delete, index|
          user_to_delete.destroy unless index.zero?
        end
      end
    end
  end

  desc 'reset legacy_subscription_id s'
  task reset_legacy_subscription_ids: :environment do
    User
      .where(legacy_subscription_id: [100000001, 100000002])
      .update_all(legacy_subscription_id: nil)
  end
end
