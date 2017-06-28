class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles, dependent: :destroy

  accepts_nested_attributes_for :roles

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, content_type: %r{ /\Aimage\/.*\Z/ }

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
end
