# frozen_string_literal: true

class Admin::SystemMessagesController < AdminController
  before_action :no_editor, only: %i[index show edit update destroy]
  before_action :set_admin_system_message, only: %i[show edit update destroy]
  before_action :set_selected

  # GET /admin/system_messages
  def index
    @admin_system_messages = Admin::SystemMessage.where(locale: I18n.locale)
  end

  # GET /admin/system_messages/1/edit
  def edit
  end

  # PATCH/PUT /admin/system_messages/1
  def update
    if @admin_system_message.update(admin_system_message_params)
      redirect_to admin_system_messages_path
    else
      render :edit
    end
  end

  private

  def set_selected
    @selected = 'system_messages'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_system_message
    @admin_system_message = Admin::SystemMessage.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_system_message_params
    params.require(:admin_system_message).permit(:title, :body, :identifier, :locale)
  end
end
