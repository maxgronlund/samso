class Api::V1::EpaperVerificationController < ApplicationController
  def index
    # ====================       ===================
    # ==================== index ===================
    # ====================       ===================
    # ====================       ===================
    @access_to_epaper = access_to_epaper?
  end
end
