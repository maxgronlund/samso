class Api::V1::EpaperVerificationController < ApplicationController
  def index

    if access_to_epaper?
      @access_to_epaper = 'Api::V1::EpaperVerification'
    else
      @access_to_epaper = 'Not authorized'
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if permitted?(user)
      Rails.logger.debug 'PERMITTED'
      Rails.logger.debug e_paper_token_url(user)
      redirect_to e_paper_token_url(user)
    else
      Rails.logger.debug 'NOT PERMITTED'
      redirect_to root_path
    end
  end

  private

  def e_paper_token_url(user)
    secret = e_paper_secret(user)
    "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2018-05-03&edition=SM1"
  end

  def e_paper_secret(user)
    create_e_paper_sceret!(user)
  end

  def create_e_paper_sceret!(user)
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

  def permitted?(user)
    return false if current_user.nil?
    return false if user.nil?
    return false unless current_user.access_to_epaper?
    return false unless current_user == user
    current_user.access_to_epaper?
  end
end


# http://localhost:3000/api/v1/epaper_verification/14938?locale=da