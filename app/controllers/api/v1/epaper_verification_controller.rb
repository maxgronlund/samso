class Api::V1::EpaperVerificationController < ApplicationController
  def index
    params.permit!
    epaper_token = EPaperToken.find_by(secret: params[:secret])
    return false if epaper_token.nil
    return false unless epaper_token.unused?
    user = epaper_token.user
    return false if user.nil?
    @access_to_epaper = user.access_to_epaper?
  end

end
