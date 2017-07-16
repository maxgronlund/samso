class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  #def create
  #  ap 'create'
  #  super
  #end

  def after_sign_in_path_for(resource)
    if session[:new_payment_path]
      session[:after_sign_in_path] = session[:new_payment_path]
      session.delete :new_payment_path
      ap session
    end
    super(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
