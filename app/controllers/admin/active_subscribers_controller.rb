# frozen_string_literal: true

class Admin::ActiveSubscribersController < AdminController
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def index
    user_ids =
      Admin::Subscription
      .where('end_date > ?', Time.zone.today)
      .pluck(:user_id)

    user_ids.uniq!

    @users =
      if params[:search] && !params[:search].empty?
        User
          .where(id: user_ids)
          .search_by_name_or_emai(params[:search])
          .order(:name)
          .page params[:page]
      else
        User
          .where(id: user_ids)
          .order(:name)
          .page params[:page]
      end
    @selected = 'users'
    @user_count = user_ids.count
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def show; end
end
