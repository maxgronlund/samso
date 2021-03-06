# frozen_string_literal: true

class Admin::AdvertisementsController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_advertisement, only: %i[show edit update destroy]

  # GET /admin/advertisements
  def index
    @admin_advertisements =
      Admin::Advertisement
      .active
      .where(locale: I18n.locale)
  end

  # GET /admin/advertisements/new
  def new
    @admin_advertisement =
      Admin::Advertisement
      .new(
        locale: I18n.locale,
        active: true,
        start_date: Date.today,
        end_date: Date.today + 1.year
      )
  end

  # GET /admin/advertisements/1/edit
  def edit
  end

  # POST /admin/advertisements
  def create
    @admin_advertisement =
      Admin::Advertisement.new(admin_advertisement_params)
    @admin_advertisement.locale = I18n.locale

    if @admin_advertisement.save
      redirect_to admin_advertisements_path
    else
      render :new
    end
  end

  # PATCH/PUT /admin/advertisements/1
  def update
    if @admin_advertisement.update(admin_advertisement_params)
      redirect_to @admin_advertisement
    else
      render :edit
    end
  end

  # DELETE /admin/advertisements/1
  def destroy
    @admin_advertisement.destroy
    redirect_to admin_advertisements_url
  end

  private

  def set_admin_advertisement
    @admin_advertisement = Admin::Advertisement.find(params[:id])
  end

  # rubocop:disable Metrics/MethodLength
  def admin_advertisement_params
    params
      .require(:admin_advertisement)
      .permit(
        :title,
        :body,
        :price_pr_view,
        :views,
        :price_pr_click,
        :clicks,
        :start_date,
        :end_date,
        :active,
        :featured,
        :featured_price,
        :price,
        :url,
        :image
      )
  end
  # rubocop:enable Metrics/MethodLength
end
