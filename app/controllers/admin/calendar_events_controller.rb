class Admin::CalendarEventsController < AdminController
  before_action :set_admin_calendar_event, only: %i[show edit update destroy]
  before_action :set_admin_calendar, only: %i[index show new edit update destroy create]

  # GET /admin/calendar_events
  def index
    @admin_calendar_events = Admin::CalendarEvent.all
  end

  # GET /admin/calendar_events/1
  def show
  end

  # GET /admin/calendar_events/new
  def new
    @admin_calendar_event =
      @admin_calendar.events.new
  end

  # GET /admin/calendar_events/1/edit
  def edit
  end

  # POST /admin/calendar_events
  def create
    @admin_calendar_event =
      @admin_calendar.events.new(admin_calendar_event_params)

    if @admin_calendar_event.save
      redirect_to @admin_calendar, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/calendar_events/1
  def update
    if @admin_calendar_event.update(admin_calendar_event_params)
      redirect_to @admin_calendar, notice: 'Calendar event was successfully updated.'
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
    @admin_calendar = Admin::Calendar.find(params[:calendar_id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_calendar_event_params
    params
      .require(:admin_calendar_event)
      .permit(
        :calendar_id,
        :title,
        :body,
        :start_time,
        :end_time,
        :gmap
      )
  end
end
