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

    def update_login_stats(request)
      @user.update_attributes(
        sign_in_count: @user.sign_in_count + 1,
        last_sign_in_at: @user.current_sign_in_at,
        current_sign_in_at: Time.zone.now.to_datetime,
        last_sign_in_ip: @user.current_sign_in_ip,
        current_sign_in_ip: request.remote_ip
      )
      sign_in_ip_service.store_sign_in_ip(@user, request)
    end

    def sign_in_ip_service
      @sign_in_ip_service ||= Admin::SignInIp::Service
    end

    def self.titleize_name(options)
      return if options[:name].nil?

      options[:name] = options[:name].downcase.titleize
    end

    def self.sanitize_email(email)
      email = email.to_s.strip.downcase
      return fake_email if email.empty?

      email
    end

    def self.sanitize_password(options)
      return unless options[:password].blank?

      options.delete :password
      options.delete :password_confirmation
    end

    def self.set_address_name(options)
      return if options[:addresses_attributes].nil?

      options[:addresses_attributes]['0'][:name] = options[:name]
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

    def self.invalid_email?(options)
      !valid_email?(options)
    end
  end
end
