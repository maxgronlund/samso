class Admin::PrintedAd < ApplicationRecord
  has_attached_file :image, styles: {
    small: '195x70#',
    medium: '390x140#'
  }, default_url: 'https://s3.amazonaws.com/samso-images/adverticements/images/defaults/:style/missing.png'

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  scope :ordered, -> {order(position: :asc)}
  scope :for_print, -> {ordered.where(active: true).last(2)}

  def printed!
    update_attributes(impressions: impressions + 1) unless updated_at > DateTime.now - 0.5.seconds
  end

  def self.new_position
    return 0 if ordered.empty?

    ordered.last.position + 1

  end
end
