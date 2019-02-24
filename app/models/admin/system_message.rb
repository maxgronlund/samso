# frozen_string_literal: true

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

  # usage Admin::SystemMessage.accept_gdpr_message
  def self.accept_gdpr_message
    @accept_gdpr_message =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'accept_gdpr_message')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'accept_gdpr_message',
        title: 'Godkendelse af databehandleraftale',
        body: "Ved at klikke knappen 'godkend' accepterer du vores handelsbetingelser, for yderlig information kan du klikke på linket 'Læs mere'"
      )
  end

  # usage Admin::SystemMessage.general_data_protection_regulation
  def self.general_data_protection_regulation
    @general_data_protection_regulation =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'general_data_protection_regulation')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'general_data_protection_regulation',
        title: 'General Data Protection Regulation',
        body: 'Hos Samsø er din data i sikre hænder. På din profil kan du altid se din data, hente din data eller slette din data.'
      )
  end

  # usage Admin::SystemMessage.cancel_account_message
  def self.cancel_account_message
    @cancel_account_message =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'cancel_account_message')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'cancel_account_message',
        title: 'Delete account',
        body: "You are about to delete your account!<br/> All informations related to it will be destroyed and can't be recovered!
        To confirm please type the following code<br/><strong>{{CANCEL_ACCOUNT_TOKEN}}</strong><br/> in the text field below"
      )
  end

  # usage Admin::SystemMessage.subscription_payment_completed
  def self.subscription_payment_completed
    @cancel_account_message =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'subscription_payment_completed')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'subscription_payment_completed',
        title: 'Payment for subscription completed',
        body: "bla bla"
      )
  end

  # usage Admin::SystemMessage.letter_to_the_edditors
  def self.letter_to_the_edditors
    @letter_to_the_edditors =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'letter_to_the_edditors')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'letter_to_the_edditors',
        title: 'Letter to the editors',
        body: ''
      )
  end

  # usage Admin::SystemMessage.printed_add
  def self.printed_add
    @printed_add =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'printed_add')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'printed_add',
        title: 'Printed ad title',
        body: 'Printed body'
      )
  end

  # usage Admin::SystemMessage.printed_ad_created
  def self.printed_ad_created
    @printed_add_created =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'printed_add_created')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'printed_add_created',
        title: 'Printed ad created title',
        body: 'Printed ad created body'
      )
  end

  def self.terms_and_conditions
    @terms_and_conditions =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'terms_and_conditions')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'terms_and_conditions',
        title: 'Terms and conditions title',
        body: 'Rerms and conditions body'
      )
  end

  def self.contact
    @contact =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'contact')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'contact',
        title: 'Contact title',
        body: 'Contact body'
      )
  end

  # usage Admin::SystemMessage.subscription_about_to_expire
  def self.subscription_about_to_expire
    @subscription_about_to_expire =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'subscription_about_to_expire')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'subscription_about_to_expire',
        title: 'Subscription about to expire',
        body: 'Subscription about to expire body'
      )
  end

  # usage Admin::SystemMessage.renew_sutscription
  def self.renew_sutscription
    @subscription_about_to_expire =
      Admin::SystemMessage
      .where(locale: I18n.locale, identifier: 'renew_sutscription')
      .first_or_create(
        locale: I18n.locale,
        identifier: 'renew_sutscription',
        title: 'Renew subscription',
        body: 'An additional period will be added to your subscription from the experiration date.'
      )
  end
end
