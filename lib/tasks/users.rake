namespace :users do
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

  desc 'remove all non editors'
  task remove_non_editors: :environment do
    User.find_each do |user|
      user.destroy unless user.editor?
    end
  end
end
