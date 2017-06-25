# namespace to confine service class to User::Service
class User < ApplicationRecord
  # services for users
  class Service
    def initialize(user)
      @user = user
    end

    def add_permission(permission)
      Role.where(
        user_id: @user.id,
        permission: permission
      ).first_or_create(
        user_id: @user.id,
        permission: permission
      )
    end

    def remove_permission(permission)
      role = @user.roles.find_by(permission: permission)
      return if role.nil?
      role.destroy
    end
  end
end
