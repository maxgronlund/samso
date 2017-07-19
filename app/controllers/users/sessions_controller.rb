class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    if session[:new_payment_path]
      session[:after_sign_in_path] = session[:new_payment_path]
      session.delete :new_payment_path
    end
    super(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    session.delete :after_sign_in_path
    session.delete :new_payment_path
    super
  end
end
