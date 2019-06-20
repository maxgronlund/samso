# the authorization dance documentation
# https://support.visiolink.com/hc/en-us/articles/200003711?input_string=integration+af+e-paper

class Api::V1::EpaperVerificationController < ApplicationController
  # this is called from https://www.e-pages.dk
  # http://samso.herokuapp.com/api/v1/epaper_verification/1?locale=da
  def index
    @access_to_e_paper =
      if access_to_e_paper?
        'Api::V1::EpaperVerification'
      else
        SecureRandom.uuid
      end
  end

  # Called when the user click on the thumb on the e_page_module
  def show
    user = User.find_by(id: params[:id])
    if permitted?(user)
      redirect_to e_paper_token_url
    else
      ap '========================================'
      ap '========================================'
      ap '========================================'
      ap params
      ap '========================================'
      ap '========================================'
      ap '========================================'

      redirect_to create_account_index_path
    end
  end

  private

  def e_paper_token_url
    secret = e_paper_secret
    # ap admin_system_setup.e_pages_date
    # "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2019-03-14&edition=SM1"
    "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=#{admin_system_setup.e_pages_date}&edition=SM1"
    #ap "http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2019-03-14&edition=SM1"
    #{}"http://login.e-pages.dk/samsoposten/open/?secret=#{secret}&date=2019-03-14&edition=SM1"
    "https://samsoposten.e-pages.pub/titles/samsoposten/880/publications/latest/?token=#{secret}"
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