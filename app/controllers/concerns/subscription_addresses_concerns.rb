module SubscriptionAddressesConcerns
  extend ActiveSupport::Concern


  def index
    @subscription = Admin::Subscription.find(params[:subscription_id])
  rescue => e
    nil
  end

  def new
    @subscription = Admin::Subscription.find(params[:subscription_id])
    @user = @subscription.user
    @address =
      @subscription
      .addresses
      .new(
        address_type: Address::TEMPORARY_ADDRESS,
        end_date: Time.zone.now.beginning_of_day + 2.weeks
      )
  end

  def edit
    @address = Address.find(params[:id])
    @subscription = @address.subscription
    @user = @subscription.user
    render_403 if unpermitted_to_edit?
  end

  def update_address
    @address = Address.find(params[:id])
    @subscription = @address.subscription
    @address.assign_attributes(address_params)
    @address_changed = @address.changed?
    @address.save
  end

  def destroy_address
    address = Address.find(params[:id])
    @subscription = address.subscription
    address.destroy
  end

  def address_changed_by(current_user, address)
    AddressUpdateMailer
      .send_message_to_system_administrator(
        current_user_id: current_user.id,
        address_id: address.id,
        subscription_id: @subscription.subscription_id,
        system_setup_id: admin_system_setup.id
      )
      .deliver
  end

  private

  def unpermitted_to_edit?
    !permitted_to_edit?
  end

  def permitted_to_edit?
    user_signed_in? && user_can_edit_subscription_address?
  end

  def user_can_edit_subscription_address?
    current_user.administrator? || @user == current_user
  end

  def address_params
    params
      .require(:address)
      .permit(
        :addressable_id, :addressable_type,
        :user_id, :name,
        :address, :zipp_code, :city,
        :start_date, :end_date,
        :subscription_id,
        :country,
        :first_name, :middle_name, :last_name,
        :street_name, :house_number, :letter, :floor, :side
      )
  end
end
