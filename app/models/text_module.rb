# raw text to place on a page
class TextModule < ApplicationRecord
  # include SectionPlugin

  has_many :page_col_modules, as: :moduleable
  # belongs_to :page

  has_attached_file :image, styles: {
    thumb: '64x64#',
    aspect_ratio_1_1: '400x400#',
    aspect_ratio_2_1: '400x225#',
    aspect_ratio_3_1: '769x180#',
    aspect_ratio_4_1: '769x270#',
    aspect_ratio_4_3: '769x270#',
    aspect_ratio_3_4: '769x270#',
    aspect_ratio_original: '769x430#',
    default_url: 'style/missing_squarde_image.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def page
    page_col.page
  end

  def page_col
    page_col_module.page_col
  end

  def page_col_module
    page_col_modules.first
  end

  def image_url(size)
    source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    return false if source.ends_with?('/missing.png')
    source
  end

  def show_link?
    !url.to_s.empty?
  end

  def self.image_styles
    [
      [I18n.t('text_module.full_width'), 'full-width'],
      [I18n.t('text_module.bordered'), 'bordered'],
      [I18n.t('text_module.circle'), 'circle']
    ]
  end

  def self.image_sizes
    [
      [I18n.t('text_module.image.aspect_ratio_1_1'), '1_1'],
      [I18n.t('text_module.image.aspect_ratio_2_1'), '2_1'],
      [I18n.t('text_module.image.aspect_ratio_3_1'), '3_1'],
      [I18n.t('text_module.image.aspect_ratio_4_1'), '4_1'],
      [I18n.t('text_module.image.aspect_ratio_4_3'), '4_3'],
      [I18n.t('text_module.image.aspect_ratio_3_4'), '3_4'],
      [I18n.t('text_module.image.size.aspect_ratio_original'), 'original'],
    ]

    # [
    #   ['4 coll squared', '4_coll_squared'],
    #   ['4 coll 16/9', '4_coll_16_9'],
    #   ['8 coll low', '8_coll_low'],
    #   ['8 col medium', '8_coll_medium'],
    #   ['8 col high', '8_coll_high']
    # ]
  end

  def self.link_layouts
    [
      [I18n.t('text_module.link_layouts.text'), 'text'],
      [I18n.t('text_module.link_layouts.button_left'), 'button_left'],
      [I18n.t('text_module.link_layouts.button_center'), 'button_center'],
      [I18n.t('text_module.link_layouts.button_right'), 'button_right']
    ]
  end

  # def self.image_sizes
  #   [
  #     [I18n.t('text_module.image.1_1'), '1_1'],
  #     [I18n.t('text_module.image.4_3'), '4_3'],
  #     [I18n.t('text_module.image.2_1'), '1_2'],
  #     [I18n.t('text_module.image.3_4'), '3_4'],
  #     [I18n.t('text_module.image.1_2'), '1_2'],
  #   ]
  # end

  def self.show_to
    [
      [I18n.t('text_module.show_to.all'), 'all'],
      [I18n.t('text_module.show_to.guests'), 'guests'],
      [I18n.t('text_module.show_to.members'), 'members']
    ]
  end
end
