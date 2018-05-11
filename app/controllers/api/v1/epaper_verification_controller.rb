class Api::V1::EpaperVerificationController < ApplicationController
  def index
    @access_to_epaper = access_to_epaper?
  end

  private

  def access_to_epaper?
    params.permit!
    epaper_token = EPaperToken.find_by(secret: params["secret"])
    return false if epaper_token.nil?
    return false unless epaper_token.unused?
    user = epaper_token.user
    return false if user.nil?
    user.access_to_epaper?
  end
end
