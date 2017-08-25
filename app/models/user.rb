class User < ApplicationRecord
  paginates_per 50
  include PgSearch
  multisearchable against: %i[name email]
  pg_search_scope :search_by_name_or_emai, against: %i[name email]
  has_secure_password

  has_many :roles, dependent: :destroy
  has_many :subscriptions, class_name: 'Admin::Subscription', dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :gallery_images, class_name: 'Admin::GalleryImage'

  accepts_nested_attributes_for :roles

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    default_url: ':style/missing_avatar.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  validates :email, uniqueness: true
  validates :email, presence: true
  validates_confirmation_of :password

  FAKE_EMAIL = '@10ff3690-389e-42ed-84dc-bd40a8d99fa5.example.com'.freeze

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
    if super_admin? || admin?
      return true unless user == self
    end
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
    source = 'https://s3.eu-central-1.amazonaws.com' + avatar.url(size).gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/avatars/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/users/avatars/missing/#{size.to_s}/missing.png'
    end
    source
  end

  def access_to_subscribed_content?
    return true if editor?
    return false unless subscriptions.any?
    subscriptions.where('end_date >= :today', today: Date.today).any?
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

  def fake_email?
    email.include?(FAKE_EMAIL)
  end

  def sanitized_email
    fake_email? ? '' : email
  end
end
