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

    def valid_confirmation_token?
      !invalid_confirmation_token?
    end

    def invalid_confirmation_token?
      @user.nil? ||
        @user.confirmation_token.nil? ||
        @user.confirmation_sent_at.nil? ||
        @user.confirmation_sent_at < Time.zone.now - 2.days
    end

    def valid_token?
      !invalid_token?
    end

    def invalid_token?
      @user.nil? ||
        @user.reset_password_sent_at.nil? ||
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

    def initialize_user
      @user.confirmation_token = nil
      @user.confirmed_at = Time.zone.now
      @user.confirmation_sent_at = nil
      @user.save
    end

    def self.titleize_name(options)
      return if options[:name].nil?
      options[:name] = options[:name].downcase.titleize
    end

    def self.sanitize_email(options)
      options[:email] = fake_email if options[:email].empty?
      options[:email].downcase!
    end

    def self.sanitize_password(options)
      return unless options[:password].to_s.empty?
      options.delete :password
      options.delete :password_confirmation
    end

    def self.fake_email
      SecureRandom.uuid + User::FAKE_EMAIL
    end

    def self.fake_password
      SecureRandom.uuid + User::FAKE_PASSWORD
    end

    def self.valid_email?(options)
      options[:email].include?('@') && options[:email].include?('.')
    end
  end
end
