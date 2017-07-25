class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    if session[:new_payment_path]
      session[:after_sign_in_path] = session[:new_payment_path]
      session.delete :new_payment_path
    end
    return super(resource) if session[:page_id].nil?
    page_with_post_path
  end

  # DELETE /resource/sign_out
  def destroy
    session.delete :after_sign_in_path
    session.delete :new_payment_path
    session.delete :page_id
    session.delete :post_id
    super
  end

  private

  def page_with_post_path
    if session[:post_id].nil?
      path = page_path(session[:page_id])
    else
      path = page_path(session[:page_id], post_id: session[:post_id])
      session.delete :post_id
    end
    session.delete :page_id
    path
  end
end
