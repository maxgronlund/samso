class Admin::NewspaperAdsController < AdminController
  def index
    @newspaper_ads = ServiceFunctions::PrintedAd.order('start_date desc')
  end

  def show
    @newspaper_ad = ServiceFunctions::PrintedAd.find(params[:id])
  end

  def new
    @newspaper_ad =
      ServiceFunctions::PrintedAd
      .new(
        start_date: Date.today.beginning_of_week + 8.day + 9.hours,
        number_of_columns: 2
      )
    set_week_and_year
  end

  def create
    @newspaper_ad = ServiceFunctions::PrintedAd.new(printed_ad_params)

    if @newspaper_ad.save
      redirect_to admin_newspaper_ads_path, notice: 'Anonncen er oprettet'
    else
      render :new
    end
  end

  def edit
    @newspaper_ad = ServiceFunctions::PrintedAd.find(params[:id])
    set_week_and_year
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

  def set_week_and_year
    y,m,d = Time.now.strftime("%Y,%m,%e").split(",")
    @this_week = Date.civil(y.to_i, m.to_i, d.to_i).cweek
    @years = y.to_i..(y.to_i + 5)
  end

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
        :contact_person,
        :state
      )
  end
end
