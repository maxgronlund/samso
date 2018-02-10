class Admin::UserSubscriptionsController < AdminController
  before_action :set_subscription_and_user, only: %i[edit update]
  
  def new
    @subscription_types = Admin::SubscriptionType.free
    set_user
    @subscription = @user.subscriptions.new
  end

  def create
    @user = User.find(params[:user_id])
    subscription = @user.subscriptions
      .new(new_subscription_params)
  end

  def edit
    
  end

  def update
    @subscription.update!(subscription_params)
    redirect_to user_path(@user)
  end

  private 

  def set_subscription_and_user
    @subscription = Admin::Subscription.find(params[:id])
    set_user
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def subscription_params
    params[:admin_subscription]
      .permit(:start_date, :end_date)
  end

  def new_subscription_params
    params[:admin_subscription]
      .permit(:subscription_type_id)
  end
end