class Admin::PrintedAdsController< AdminController
  before_action :set_admin_printed_ad, only: %i[edit update destroy]
  layout "print", only: [:show]



  # GET /admin/printed_ads
  def index
    @admin_printed_ads = Admin::PrintedAd.order(position: :desc)
  end

  # GET /admin/printed_ads/1
  # def show
  #   @printed_ads = Admin::PrintedAd.order(:position).last(2)
  # end

  # GET /admin/printed_ads/new
  def new
    @admin_printed_ad =
      Admin::PrintedAd
      .new(
        position: Admin::PrintedAd.new_position,
        active: true
      )
  end

  # GET /admin/printed_ads/1/edit
  def edit
  end

  # POST /admin/printed_ads
  def create
    @admin_printed_ad = Admin::PrintedAd.new(admin_printed_ad_params)

    if @admin_printed_ad.save
      redirect_to admin_printed_ads_path
    else
      render :new
    end
  end

  # PATCH/PUT /admin/printed_ads/1
  def update
    if @admin_printed_ad.update(admin_printed_ad_params)
      redirect_to admin_printed_ads_path
    else
      render :edit
    end
  end

  # DELETE /admin/printed_ads/1
  def destroy
    @admin_printed_ad.destroy
    redirect_to admin_printed_ads_url, notice: 'Printed ad was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_printed_ad
      @admin_printed_ad = Admin::PrintedAd.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_printed_ad_params
      params
        .require(:admin_printed_ad)
        .permit(
          :title,
          :body,
          :impressions,
          :image,
          :position,
          :active
        )
    end
end
