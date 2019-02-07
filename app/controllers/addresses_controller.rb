class AddressesController < ApplicationController
  # before_action :set_address, only: %i[show edit update destroy]

  # GET /addresses
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  def show
  end

  # GET /addresses/new
  def new

    @subscription = Admin::Subscription.find(params[:subscription_id])
    primary_address = @subscription.primary_address
    @user = @subscription.user
    @address =
      @subscription
      .addresses
      .new(
        name: primary_address.name,
        address: primary_address.address,
        zipp_code: primary_address.zipp_code,
        city: primary_address.city,
        start_date: Date.today,
        end_date: Date.today + 1.month,
        address_type: Address::TEMPORARY_ADDRESS
      )
  end

  # GET /addresses/1/edit
  def edit
    @subscription = Admin::Subscription.find(params[:subscription_id])
    @address = @subscription.addresses.find(params[:id])
  end

  # POST /addresses
  def create
    @subscription = Admin::Subscription.find(address_params[:addressable_id])
    @address = @subscription.addresses.new(address_params)
    @address.address_type = Address::TEMPORARY_ADDRESS

    if @address.save
      redirect_to subscription_address_path(@subscription)
    else
      render :new
    end
  end

  # PATCH/PUT /addresses/1
  def update
    @address = Address.find(address_params[:addressable_id])
    if @address.update(address_params)
      redirect_to subscription_address_path(@address.addressable.id)
    else
      render :edit
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def address_params
    params
      .require(:address)
      .permit(
        :addressable_id,
        :addressable_type,
        :user_id,
        :name,
        :address,
        :zipp_code,
        :city,
        :start_date,
        :end_date,
        :subscription_id
      )
  end
end
