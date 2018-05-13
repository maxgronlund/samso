class Api::V1::EpaperVerificationController < ApplicationController
  def index
    @access_to_epaper = access_to_epaper?
  end

  private

  def access_to_epaper?
    params.permit!
    Rails.logger.debug '-----------string------------'
    Rails.logger.debug params["secret"]
    Rails.logger.debug '-----------key------------'
    Rails.logger.debug params[:secret]

    epaper_token = EPaperToken.find_by(secret: params[:secret])
    Rails.logger.debug epaper_token
    Rails.logger.debug '-----------------------'
    return false if epaper_token.nil?
    return false unless epaper_token.unused?
    user = epaper_token.user
    return false if user.nil?
    user.access_to_epaper?
  end
end
