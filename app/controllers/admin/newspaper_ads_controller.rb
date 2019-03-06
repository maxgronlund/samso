class Admin::NewspaperAdsController < AdminController
  def index
    @newspaper_ads = ServiceFunctions::PrintedAd.order('start_date desc')
  end

  def show
    @newspaper_ad = ServiceFunctions::PrintedAd.find(params[:id])
  end

  def edit
    @newspaper_ad = ServiceFunctions::PrintedAd.find(params[:id])
  end

  def update
    @newspaper_ad = ServiceFunctions::PrintedAd.find(params[:id])
    if @newspaper_ad.update(printed_ad_params)
      redirect_to admin_newspaper_ads_path, notice: 'Anonncen er blevet opdateret'
    else
      render :edit
    end
  end

  def destroy
    printed_ad = ServiceFunctions::PrintedAd.find(params[:id])
    printed_ad.destroy
    redirect_to admin_newspaper_ads_path, notice: 'Anonncen er blevet slettet.'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def printed_ad_params
    params
      .require(:service_functions_printed_ad)
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
        :contact_person
      )
  end
end
