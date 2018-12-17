# frozen_string_literal: true

# Advertisement
class Admin::Advertisement < ApplicationRecord
  scope :active, -> { where(active: true) }

  has_attached_file :image, styles: {
    small: '100x100#',
    medium: '200x200#',
    large: '300x300#'
  }, default_url: 'https://s3.amazonaws.com/samso-images/adverticements/images/defaults/:style/missing.png'

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def viewed!
    update_attributes(views: views + 1) unless updated_at > DateTime.now - 0.5.seconds
  end

  def clicked!
    update_attributes(clicks: clicks + 1)
  end
end
