# System messages
class Admin::SystemMessage < ApplicationRecord
  def self.welcome
    Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'welcome')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'welcome',
        title: 'welcome'
      )
  end

  def self.resend_password
    Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'resend_password')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'resend_password',
        title: 'resend_password'
      )
  end

  def self.new_password_email
    Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'new_password_email')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'new_password_email',
        title: 'new_password_email'
      )
  end

  def self.confirm_email_email
    Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'new_password_email')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'confirm_email_email',
        title: 'confirm_email_email'
      )
  end
end
