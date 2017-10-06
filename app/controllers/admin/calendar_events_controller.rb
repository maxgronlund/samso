class Admin::CalendarEventsController < ApplicationController
  before_action :set_admin_calendar_event, only: [:show, :edit, :update, :destroy]
   before_action :set_admin_calendar, only: %i[show new edit update destroy]

  # GET /admin/calendar_events
  def index
    @admin_calendar_events = Admin::CalendarEvent.all
  end

  # GET /admin/calendar_events/1
  def show
  end

  # GET /admin/calendar_events/new
  def new
    @admin_calendar_event = Admin::CalendarEvent.new
  end

  # GET /admin/calendar_events/1/edit
  def edit
  end

  # POST /admin/calendar_events
  def create
    @admin_calendar_event = Admin::CalendarEvent.new(admin_calendar_event_params)

    if @admin_calendar_event.save
      redirect_to @admin_calendar_event, notice: 'Calendar event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/calendar_events/1
  def update
    if @admin_calendar_event.update(admin_calendar_event_params)
      redirect_to @admin_calendar_event, notice: 'Calendar event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/calendar_events/1
  def destroy
    @admin_calendar_event.destroy
    redirect_to admin_calendar_events_url, notice: 'Calendar event was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_calendar_event
    @admin_calendar_event = Admin::CalendarEvent.find(params[:id])
  end

  def set_admin_calendar
    ap @admin_calendar = Admin::Calendar.find(params[:calendar_id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_calendar_event_params
    params
    require(:admin_calendar_event)
      .permit(:admin_calendar_id, :title)
  end
end
