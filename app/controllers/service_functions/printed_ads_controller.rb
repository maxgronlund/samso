# require 'newspaper_ad_mailer'

class ServiceFunctions::PrintedAdsController < ApplicationController
  before_action :set_service_functions_printed_ad, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: %i[index new edit show]

  # GET /service_functions/printed_ads
  def index

  end

  # GET /service_functions/printed_ads/1
  def show
  end

  # GET /service_functions/printed_ads/new
  def new
    @service_functions_printed_ad =
      ServiceFunctions::PrintedAd
      .new(
        number_of_columns: 2
      )
    set_week_and_year
  end

  # GET /service_functions/printed_ads/1/edit
  def edit
  end

  # POST /service_functions/printed_ads
  def create
    @service_functions_printed_ad =
      ServiceFunctions::PrintedAd
      .new(service_functions_printed_ad_params)

    if @service_functions_printed_ad.save
      NewspaperAdMailer.send_message_to_administrators(
        printed_ad_id: @service_functions_printed_ad.id,
        link: admin_newspaper_ad_url(@service_functions_printed_ad)
      ).deliver
      redirect_to service_functions_printed_ads_path, notice: 'show'
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

    def set_week_and_year
      y,m,d = Time.now.strftime("%Y,%m,%e").split(",")
      @this_week = Date.civil(y.to_i, m.to_i, d.to_i).cweek
      @years = y.to_i..(y.to_i + 5)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_service_functions_printed_ad
      @service_functions_printed_ad = ServiceFunctions::PrintedAd.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_functions_printed_ad_params
      params.require(:service_functions_printed_ad)
        .permit(
          :start_date,
          :number_of_columns,
          :body,
          :comment,
          :name,
          :address,
          :zipp_code,
          :city,
          :email,
          :phone,
          :contact_person,
          :week,
          :year
        )
    end

    def set_page
      @landing_page     = admin_system_setup.landing_page || Page.find_by(locale: I18n.locale)
      @footer           = @page.footer
      @body_style       = @page.body_style
      session[:page_id] = @page.id
    end
end
