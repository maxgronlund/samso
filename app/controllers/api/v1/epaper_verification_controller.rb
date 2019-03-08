class Api::V1::EpaperVerificationController < ApplicationController
  def index
    @access_to_e_paper =
      if access_to_e_paper?
        'Api::V1::EpaperVerification'
      else
        SecureRandom.uuid
      end
  end

  def show
    user = User.find_by(id: params[:id])
    if permitted?(user)
      redirect_to e_paper_token_url
    else
      redirect_to root_path
    end
  end

  private

  def e_paper_token_url
    secret = e_paper_secret
    "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2019-03-08&edition=SM1"
    # "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=#{Time.zone.now.strftime('%Y-%m-%d')}&edition=SM1"
  end

  def e_paper_secret
    current_user
      .e_paper_tokens
      .where.not(secret: nil)
      .first_or_create(
        secret: SecureRandom.uuid
      ).secret
  end

  def access_to_e_paper?
    params.permit!
    e_paper_token = EPaperToken.find_by(secret: params[:secret])
    return false if e_paper_token.nil?
    return false unless e_paper_token.grand_access?

    user = e_paper_token.user
    return false if user.nil?

    user.access_to_e_paper?
  end

  def permitted?(user)
    return false if current_user.nil?
    return false if user.nil?
    return false unless current_user.access_to_e_paper?
    return false unless current_user == user

    current_user.access_to_e_paper?
  end
end
