require 'rails_helper'

RSpec.describe User, type: :model do
  before(:context) do
    @user =
      FactoryBot
      .create(
        :user,
        confirmation_token: "somefaketoken",
        confirmation_sent_at: Time.zone.now,
        confirmed_at: Time.zone.now
      )
  end

  context 'user' do  # (almost) plain English
    it 'always has a primary address' do
      expect(@user.address.address_type).to eq("primary_address")
    end

    it 'has no payments' do
      expect(@user.payments).to eq([])
    end

    it 'has pending payments' do
      @payment =
        FactoryBot
        .create(
          :payment,
          user_id: @user.id,
          payable_id: "1",
          payable_type: "Admin::Subscription"
        )
      expect(@user.pending_payments.first).to eq(@payment)
    end

    it 'destroy pending payments' do
      @payment =
        FactoryBot
        .create(
          :payment,
          user_id: @user.id,
          payable_id: "1",
          payable_type: "Admin::Subscription"
        )
      @user.destroy_pending_payments
      expect(@user.pending_payments).to eq([])
    end

    it 'has no pending payments' do
      @payment =
        FactoryBot
        .create(
          :payment,
          user_id: @user.id,
          payable_id: "1",
          payable_type: "Admin::Subscription",
          state: Payment::ACCEPTED
        )
      expect(@user.pending_payments).to eq([])
    end

    it 'has a street address' do
      address =
        FactoryBot
        .create(
          :address,
          addressable_id: @user.id,
          addressable_type: @user.class.name
        )
      ap address
      ap @user.addresses
      ap @user.street_address
    end
  end
end
