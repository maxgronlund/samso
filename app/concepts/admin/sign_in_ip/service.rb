class Admin::SignInIp < ApplicationRecord
  # services for users
  class Service
    def self.store_sign_in_ip(user, request)
      sign_in_ip =
        user
        .sign_in_ips
        .where(
          ip: request.remote_ip
        ).first_or_initialize(
          ip: request.remote_ip
        )
      sign_in_ip.sign_in_at = Time.zone.now.to_datetime
      sign_in_ip.count += 1 if sign_in_ip.persisted?
      sign_in_ip.save
      remove_old_sign_in_ips(user)
    end

    def self.remove_old_sign_in_ips(user)
      user
        .sign_in_ips
        .where(
          'sign_in_at <= :two_weeks_ago', two_weeks_ago: Time.zone.now.to_datetime - 2.weeks
        )
        .destroy_all
    end

    def self.sanitize
      Admin::SignInIp
        .where('sign_in_at <= ?', Time.zone.now.to_datetime - 2.weeks)
        .destroy_all
    end
  end
end
