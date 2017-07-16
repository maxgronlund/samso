class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, dependent: :destroy
  has_many :subscriptions, class_name: 'Admin::Subscription', dependent: :destroy
  has_many :payments, dependent: :destroy

  accepts_nested_attributes_for :roles

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    default_url: ':style/missing_avatar.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  validates :name, :email, presence: true

  def super_admin?
    roles.where(permission: Role::SUPER_ADMIN).any?
  end

  def admin?
    roles.where(permission: Role::ADMIN).any?
  end

  def can_edit?(user)
    return true unless user.persisted?
    super_admin? && user != self
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
    return false unless subscriptions.any?
    return subscriptions.where("end_date >= :today", {today: Date.today}).any?
    false
  end

  def self.super_admin
    Role.find_by(permission: Role::SUPER_ADMIN).user
  end
end
