class Api::V1::EpaperVerificationController < ApplicationController
  def index
    # ====================       ===================
    # ==================== index ===================
    # ====================       ===================
    # ====================       ===================
    ap params
    ap current_user
    @access_to_epaper = access_to_epaper?
  end
end
