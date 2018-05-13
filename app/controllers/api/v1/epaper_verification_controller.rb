class Api::V1::EpaperVerificationController < ApplicationController
  def index
    if true
      @access_to_epaper = 'Api::V1::EpaperVerification'
    else
      @access_to_epaper = 'Not authorized'
    end
  end

  def show
    current_user = User.find(params[:id])
    redirect_to e_paper_token_url(current_user)
  end

  private

  def e_paper_token_url(current_user)
    secret = e_paper_secret(current_user)
    "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2018-05-03&edition=SM1"
  end

  def e_paper_secret(current_user)
    current_user.e_paper_tokens
      .where
      .not(secret: nil)
      .first_or_create(
        secret: SecureRandom.uuid
      ).secret
  end

  def access_to_epaper?
    params.permit!
    epaper_token = EPaperToken.find_by(secret: params[:secret])
    return false if epaper_token.nil?
    return false unless epaper_token.grand_access?
    user = epaper_token.user
    return false if user.nil?
    user.access_to_epaper?
  end
end
