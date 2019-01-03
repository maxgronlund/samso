namespace :users do
  desc 'delete dublets'
  task delete_dublets: :environment do
    User.find_each do |user|
      users = User.where(legacy_subscription_id: user.legacy_subscription_id)
      if users.count > 1
        users.each_with_index do |user_to_delete, index|
          user_to_delete.destroy unless index.zero?
        end
      end
    end
  end
end
