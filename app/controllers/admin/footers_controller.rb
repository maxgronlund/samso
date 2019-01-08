# frozen_string_literal: true

class Admin::FootersController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_footer, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/footers
  # GET /admin/footers.json
  def index
    @admin_footers = Admin::Footer.where(locale: I18n.locale)
  end

  # GET /admin/footers/new
  def new
    @admin_footer = Admin::Footer.new
  end

  # GET /admin/footers/1/edit
  def edit
  end

  # POST /admin/footers
  # POST /admin/footers.json
  def create
    @admin_footer = Admin::Footer.new(admin_footer_params)
    @admin_footer.locale = I18n.locale
    if @admin_footer.save
      redirect_to admin_footers_path
    else
      render :new
    end
  end

  # PATCH/PUT /admin/footers/1
  # PATCH/PUT /admin/footers/1.json
  def update
    if @admin_footer.update(admin_footer_params)
      redirect_to admin_footers_path
    else
      render :edit
    end
  end

  # DELETE /admin/footers/1
  # DELETE /admin/footers/1.json
  def destroy
    @admin_footer.destroy
    redirect_to admin_footers_path
  end

  private

  def set_selected
    @selected = 'footers'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_footer
    @admin_footer = Admin::Footer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_footer_params
    params.require(:admin_footer).permit(
      :title,
      :locale,
      :about_page_id,
      :about_page_link_name,
      :email,
      :term_of_usage_page_id,
      :term_of_usage_page_link_name,
      :copyright_page_id,
      :copyright_page_link_name,
      :company_name,
      :phone,
      :vat_nr
    )
  end
end
