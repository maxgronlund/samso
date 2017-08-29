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

    def valid_token?
      !invalid_token
    end

    def invalid_token
      @user.nil? ||
        @user.reset_password_token.nil? ||
        @user.reset_password_sent_at < Time.zone.now - 2.days
    end

    def reset_user(password_params = {})
      @user.reset_password_token = nil
      @user.current_sign_in_at = Time.zone.now
      @user.reset_password_sent_at = nil
      unless password_params.empty?
        @user.password = password_params[:password]
        @user.password_confirmation = password_params[:password_confirmation]
      end
      @user.save
    end
  end
end
