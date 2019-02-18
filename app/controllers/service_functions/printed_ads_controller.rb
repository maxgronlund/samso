class ServiceFunctions::PrintedAdsController < ApplicationController
  before_action :set_service_functions_printed_ad, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: %i[index new edit show]

  # GET /service_functions/printed_ads
  def index
    @service_functions_printed_ads = ServiceFunctions::PrintedAd.all

    # @page =
    #   Page
    #   .includes(page_rows: [page_cols: [:page_col_modules]])
    #  .find(params[:id])

  rescue
    render_404
  end

  # GET /service_functions/printed_ads/1
  def show
  end

  # GET /service_functions/printed_ads/new
  def new
    @service_functions_printed_ad =
      ServiceFunctions::PrintedAd
      .new(
        start_date: Date.today.beginning_of_week + 8.day + 9.hours
      )
  end

  # GET /service_functions/printed_ads/1/edit
  def edit
  end

  # POST /service_functions/printed_ads
  def create
    @service_functions_printed_ad = ServiceFunctions::PrintedAd.new(service_functions_printed_ad_params)

    if @service_functions_printed_ad.save
      redirect_to service_functions_printed_ads_path, notice: 'printed add crea'
       # TODO: send message to system admin
    else
      render :new
    end
  end

  # PATCH/PUT /service_functions/printed_ads/1
  def update
    if @service_functions_printed_ad.update(service_functions_printed_ad_params)
      redirect_to @service_functions_printed_ad, notice: 'Printed ad was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /service_functions/printed_ads/1
  def destroy
    @service_functions_printed_ad.destroy
    redirect_to service_functions_printed_ads_url, notice: 'Printed ad was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_functions_printed_ad
      @service_functions_printed_ad = ServiceFunctions::PrintedAd.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_functions_printed_ad_params
      params.require(:service_functions_printed_ad).permit(:start_date, :number_of_columns, :body, :comment, :name, :address, :zipp_code, :city, :email, :phone, :contact_person)
    end

    def set_page
      @landing_page     = admin_system_setup.landing_page || Page.find_by(locale: I18n.locale)
      @footer           = @page.footer
      @body_style       = @page.body_style
      session[:page_id] = @page.id
    end
end
