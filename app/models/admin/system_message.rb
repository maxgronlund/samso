# System messages
class Admin::SystemMessage < ApplicationRecord
  def self.welcome
    @welcome ||=
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'welcome')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'welcome',
        title: 'welcome'
      )
  end

  def self.resend_password
    @resend_password =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'resend_password')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'resend_password',
        title: 'resend_password'
      )
  end

  def self.new_password_email
    @new_password_email =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'new_password_email')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'new_password_email',
        title: 'new_password_email'
      )
  end

  # usage Admin::SystemMessage.confirm_email_email
  def self.confirm_email
    @confirm_email =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'confirm_email')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'confirm_email',
        title: 'Confirm email',
        body: 'You will receive a confirmation email in within a few minutes'
      )
  end

  # usage Admin::SystemMessage.confirm_email_email
  def self.thanks_for_signing_up_email
    @confirm_email =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'thanks_for_signing_up_email')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'thanks_for_signing_up_email',
        title: 'Thanks for signing up',
        body: 'Please click on the link belove to confirm you email'
      )
  end

  # usage Admin::SystemMessage.thanks_for_signing_up
  def self.thanks_for_signing_up
    @signed_up_message =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'thanks_for_signing_up')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'thanks_for_signing_up',
        title: 'Thanks for signing up',
        body: 'An confirmation email is send to your account'
      )
  end
end
