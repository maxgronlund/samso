# frozen_string_literal: true

class Admin::ClickOnAdvertisementsController < ApplicationController
  def update
    acvertisement = Admin::Advertisement.find(update_params[:id])
    acvertisement.clicked!
    render body: nil
  end

  private

  def update_params
    params.permit!
  end
end
