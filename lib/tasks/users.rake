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
end
