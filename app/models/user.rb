# rubocop:disable Metrics/ClassLength
class User < ApplicationRecord
  paginates_per 50
  include PgSearch
  multisearchable against: %i[name email]
  pg_search_scope :search_by_name_or_emai, against: %i[name email legacy_subscription_id]
  has_secure_password
  attr_accessor :delete_avatar, :validate_address, :cancel_account_token
  has_many :roles, dependent: :destroy
  has_many :subscriptions, class_name: 'Admin::Subscription', dependent: :destroy
  has_many :e_paper_tokens, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :gallery_images, class_name: 'Admin::GalleryImage'
  has_many :blog_posts, class_name: 'Admin::BlogPost'
  has_many :comments, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :subscription_addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :roles

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }, default_url: 'https://s3.amazonaws.com/samso-images/users/avatars/defaults/:style/missing.png'

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  before_validation { avatar.clear if delete_avatar == '1' }
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates_confirmation_of :password
  # validates_with UserAddressValidator, if: :validate_subscription_address
  validates_with User::Validator

  FAKE_EMAIL = '@10ff3690-389e-42ed-84dc-bd40a8d99fa5.example.com'.freeze
  FAKE_PASSWORD = 'dd7ed83bfb1e6d17aaa7798c3f69054fa910aac19b395dd037cc9abc4cb16db8'.freeze

  # def validate_subscription_address
  #   # ap @validate_address
  # end

  def super_admin?
    roles.where(permission: Role::SUPER_ADMIN).any?
  end

  def admin?
    roles.where(permission: Role::ADMIN).any?
  end

  def administrator?
    admin? || super_admin?
  end

  def editor?
    return true if roles.where(permission: Role::EDITOR).any?
    return true if admin?
    return true if super_admin?
    false
  end

  def can_edit?(user)
    if administrator?
      return true unless user == self
    end
    false
  end

  def can_access?(user)
    return true if administrator?
    return true if user == self
    false
  end

  def role_names
    permissions = ''
    roles.each do |role|
      permissions += I18n.t('user.' + role.permission) + ' '
    end
    permissions
  end

  def avatar_url(size)
    return avatar.url(size) if avatar.exists?
    default_url = avatar.url(size)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=182&d=#{CGI.escape(default_url)}"
  end

  def access_to_subscribed_content?
    return true if free_subscription
    active_subscription?
  end

  def access_to_e_paper?
    return true if free_subscription
    Admin::SubscriptionType
      .where(id: subscription_type_ids)
      .any?
  end

  def active_subscription?
    @active_subscription ||=
      valid_subscriptions.any?
  end

  def no_active_subscription?
    @no_active_subscription ||=
      valid_subscriptions.empty?
  end

  def last_valid_subscription
    @last_valid_subscription ||=
      valid_subscriptions.last
  end

  def valid_subscriptions
    @valid_subscriptions ||=
      subscriptions
      .where(
        'start_date <= :start_date AND end_date >= :end_date',
        start_date: Date.today.beginning_of_day,
        end_date: Date.today.beginning_of_day
      )
  end

  def subscription_id
    return last_valid_subscription.subscription_id if last_valid_subscription.present?
    return '' if legacy_subscription_id.blank?
    legacy_subscription_id + '!'
  end

  def expired_subscriber?
    return false if access_to_subscribed_content?
    subscriptions.any? && no_active_subscription?
  end

  def self.super_admin
    Role.find_by(permission: Role::SUPER_ADMIN).user
  end

  def can_manage_resource?(resource)
    case resource.class.name

    when 'Admin::GalleryImage'
      return resource.user_id == id
    end

    false
  end

  def fake_password?
    password_digest.include?(FAKE_PASSWORD)
  end

  def fake_email?
    email.include?(FAKE_EMAIL)
  end

  def sanitized_email
    fake_email? ? '' : email
  end

  def subscription_nr
    legacy_subscription_id || legacy_id
  end

  def subscription_type_ids
    @subscription_type_ids ||=
      valid_subscriptions
      .pluck(:subscription_type_id)
      .uniq
  end
end
# rubocop:enable Metrics/ClassLength
