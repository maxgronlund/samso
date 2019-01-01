# frozen_string_literal: true

class Admin::CalendarsController < AdminController
  before_action :set_admin_calendar, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/calendars
  def index
    @admin_calendars = Admin::Calendar.all
  end

  # GET /admin/calendars/1
  def show
  end

  # GET /admin/calendars/new
  def new
    @admin_calendar = Admin::Calendar.new
  end

  # GET /admin/calendars/1/edit
  def edit
  end

  # POST /admin/calendars
  def create
    @admin_calendar = Admin::Calendar.new(admin_calendar_params)
    @admin_calendar.locale = I18n.locale
    if @admin_calendar.save
      redirect_to @admin_calendar
    else
      render :new
    end
  end

  # PATCH/PUT /admin/calendars/1
  def update
    if @admin_calendar.update(admin_calendar_params)
      redirect_to @admin_calendar
    else
      render :edit
    end
  end

  # DELETE /admin/calendars/1
  def destroy
    @admin_calendar.destroy
    redirect_to admin_calendars_url
  end

  private

  def set_selected
    @selected = 'calendars'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_calendar
    @admin_calendar = Admin::Calendar.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_calendar_params
    params.require(:admin_calendar).permit(:admin_calendar_module_id, :title)
  end
end
