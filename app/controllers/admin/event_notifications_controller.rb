class Admin::EventNotificationsController < AdminController
  before_action :set_admin_event_notification, only: [:show, :edit, :update, :destroy]

  # GET /admin/event_notifications
  def index
    @admin_event_notifications = Admin::EventNotification.all
  end

  # GET /admin/event_notifications/1
  def show
    @admin_event_notification.update(state: 'read')
  end

  # GET /admin/event_notifications/new
  def new
    @admin_event_notification = Admin::EventNotification.new
  end

  # GET /admin/event_notifications/1/edit
  def edit
  end

  # POST /admin/event_notifications
  def create
    @admin_event_notification = Admin::EventNotification.new(admin_event_notification_params)

    if @admin_event_notification.save
      redirect_to @admin_event_notification, notice: 'Event notification was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/event_notifications/1
  def update
    if @admin_event_notification.update(admin_event_notification_params)
      redirect_to @admin_event_notification, notice: 'Event notification was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/event_notifications/1
  def destroy
    @admin_event_notification.destroy
    redirect_to admin_event_notifications_url, notice: 'Event notification was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_event_notification
      @admin_event_notification = Admin::EventNotification.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_event_notification_params
      params.require(:admin_event_notification).permit(:title, :body, :message_type, :state)
    end
end
