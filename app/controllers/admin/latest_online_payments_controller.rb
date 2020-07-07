class Admin::LatestOnlinePaymentsController < AdminController
  def index
    @users =
      if params[:search].present?
        User
          .where.not(latest_online_payment: nil)
          .order(latest_online_payment: :desc)
          .search(
            params[:search],
            page: params[:page],
            per_page: 50
          )
      else
        User
          .where
          .not(latest_online_payment: nil)
          .order(latest_online_payment: :desc)
          .page params[:page]
      end
    @selected = 'users'
    @user_count = User.count
  end
end
