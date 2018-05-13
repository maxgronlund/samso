class Api::V1::EpaperVerificationController < ApplicationController
  def index
    @access_to_epaper = true#access_to_epaper?
  end

  private

  def access_to_epaper?

    params.permit!
    Rails.logger.debug '-----------key------------'
    Rails.logger.debug params[:secret]

    epaper_token = EPaperToken.find_by(secret: params[:secret])

    Rails.logger.debug '-----------epaper_token.nil?------------'
    Rails.logger.debug epaper_token.nil?
    Rails.logger.debug epaper_token.instance_variables
    #return false if epaper_token.nil?
    Rails.logger.debug '-------------unused?----------'
    Rails.logger.debug epaper_token.unused?
    # return false unless epaper_token.unused?
    Rails.logger.debug '-------------user.nil?----------'
    Rails.logger.debug epaper_token.user.instance_variables
    user = epaper_token.user
    #return false if user.nil?
    Rails.logger.debug '-------------access_to_epaper----------'
    Rails.logger.debug user.access_to_epaper?
    'true'
  rescue
    Rails.logger.debug '-------------rescued----------'
    'true'
  end
end
