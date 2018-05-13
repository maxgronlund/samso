class Api::V1::EpaperVerificationController < ApplicationController
  def index
    @access_to_epaper = access_to_epaper?
  end

  private

  def access_to_epaper?
    params.permit!
    Rails.logger.debug '-----------key------------'
    Rails.logger.debug params[:secret]

    epaper_token = EPaperToken.find_by(secret: params[:secret])

    Rails.logger.debug '-----------epaper_token------------'
    Rails.logger.debug epaper_token
    return false if epaper_token.nil?
    Rails.logger.debug '-------------unused----------'
    Rails.logger.debug epaper_token.unused?
    return false unless epaper_token.unused?
    Rails.logger.debug '-------------user----------'
    Rails.logger.debug epaper_token.user
    user = epaper_token.user
    return false if user.nil?
    Rails.logger.debug '-------------access_to_epaper----------'
    user.access_to_epaper?
    true
  end
end
