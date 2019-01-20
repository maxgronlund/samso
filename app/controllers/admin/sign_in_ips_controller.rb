class Admin::SignInIpsController < AdminController
  # GET /admin/sign_in_ips
  def index
    Admin::SignInIp::Service.sanitize
    @users = User.where('sign_in_ips_count >= ?', 5)
  end
end
