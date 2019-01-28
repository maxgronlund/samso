class Admin::LatestOnlinePaymentsController < AdminController
  def index
    @users =
      if params[:search].present?
        User
          .where
          .not(latest_online_payment: nil)
          .search_by_name_or_email(params[:search])
          .order(:latest_online_payment)
          .page params[:page]
      else
        User
          .where
          .not(latest_online_payment: nil)
          .order(latest_online_payment: :asc)
          .page params[:page]
      end
    @selected = 'users'
    @user_count = User.count
  end
end
