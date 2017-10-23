class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def up
    User.find_each do |user|
      validate_role(user)
    end
  end

  private

  def validate_role(user)
    return unless user.roles.empty?
    user.roles.create(permission: 'member')
  end
end
