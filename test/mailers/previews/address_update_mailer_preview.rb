# usage http://localhost:3000/rails/mailers/address_update_mailer/send_message_to_system_administrator
class AddressUpdateMailerPreview < ActionMailer::Preview
  def send_message_to_system_administrator
    AddressUpdateMailer
      .send_message_to_system_administrator(
        current_user_id: current_user.id,
        address_id: address.id,
        subscription_id: @subscription.id,
        system_setup_id: admin_system_setup.id
      )
  end

  private

  def current_user
    @current_user ||=
      User
      .find_by(email: 'admin@example.com')
  end

  def address
    @address ||=
      subscription
      .addresses
      .temporary_address
  end

  def admin_system_setup
    @admin_system_setup ||=
      Admin::SystemSetup
      .find_by(locale: I18n.locale)
  end

  def subscription
    @subscription ||=
      current_user
      .subscriptions
      .first
  end
end
