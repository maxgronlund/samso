# join a modyle to a col
class PageColModule < ApplicationRecord
  belongs_to :page_col
  belongs_to :moduleable, polymorphic: true
  scope :ordered, -> { order('position ASC') }

  def modulable_path
    moduleable.class.name.underscore.gsub('admin/', '') + 's/show'
  end

  def modulable_edit_path
    'admin/' + moduleable.class.name.underscore + 's/edit'
  end

  def admin_modulable_path
    'admin/' + moduleable.class.name.underscore.gsub('admin/', '') + 's/show'
  end

  def style
    "margin-bottom: #{margin_bottom}px;"
  end

  def self.permissions
    [
      [I18n.t('page_col_module.show.all'), 'all'],
      [I18n.t('page_col_module.show.guests_only'), 'guests_only'],
      [I18n.t('page_col_module.show.members_only'), 'members_only'],
      [I18n.t('page_col_module.show.subscribers_only'), 'subscribers_only'],
      [I18n.t('page_col_module.show.expired_subscribers'), 'expired_subscribers']
    ]
  end

  def permit?(current_user)
    return true if access_to_all?
    return true if access_to_members_only?(current_user)
    return true if access_to_guests_only?(current_user)
    return true if access_to_subscribers_only?(current_user)
    access_to_expired_subscribers?(current_user)
  end

  private

  def access_to_all?
    access_to == 'all'
  end

  def access_to_guests_only?(current_user)
    access_to == 'guests_only' && current_user.nil?
  end

  def access_to_members_only?(current_user)
    return false if current_user.nil?
    access_to == 'members_only'
  end

  def access_to_subscribers_only?(current_user)
    return false if current_user.nil?
    return false unless access_to == 'subscribers_only'
    current_user.access_to_subscribed_content?
  end

  def access_to_expired_subscribers?(current_user)
    return false if current_user.nil?
    return false unless access_to == 'expired_subscribers'
    current_user.expired_subscriber?
  end
end
