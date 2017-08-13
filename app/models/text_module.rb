# raw text to place on a page
class TextModule < ApplicationRecord
  include SectionPlugin

  belongs_to :page, optional: true
  has_attached_file :image, styles: {
    size_640_240: '640x240#',
    '4_coll_squared'.to_sym => '400x400#',
    '4_coll_16_9'.to_sym => '400x225#',
    '8_coll_low'.to_sym => '769x180#',
    '8_coll_medium'.to_sym => '769x270#',
    '8_coll_high'.to_sym => '769x430#',
    default_url: 'style/missing_squarde_image.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  LAYOUTS = %w[
    alfa-romeo
    aston-martin
    audi
    bmw
    bugatti
    buick
    cadillac
    chevron
    citroen
    daihatsu
    dodge
    fiat
    ford
  ].freeze

  def page_module
    PageModule.find_by(
      moduleable_type: 'TextModule',
      moduleable_id: id
    )
  end

  def image_url(size)
    source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    return false if source.ends_with?('/missing.png')
    source
  end

  def show_link?
    !url.to_s.empty?
  end

  def self.image_sizes
    [
      ['4 coll squared', '4_coll_squared'],
      ['4 coll 16/9', '4_coll_16_9'],
      ['8 coll low', '8_coll_low'],
      ['8 col medium', '8_coll_medium'],
      ['8 col high', '8_coll_high']
    ]
  end

  def self.show_to
    [
      [I18n.t('text_module.show_to.all'), 'all'],
      [I18n.t('text_module.show_to.guests'), 'guests'],
      [I18n.t('text_module.show_to.members'), 'members']
    ]
  end
end
