# raw text to place on a page
class TextModule < ApplicationRecord
  # include SectionPlugin

  has_many :page_col_modules, as: :moduleable
  # belongs_to :page

  has_attached_file :image, styles: {
    thumb: '64x64#',
    small_1_1: '540x540#',
    large_1_1: '960x960#',
    small_4_3: '540x405#',
    large_4_3: '960x720#',
    small_2_1: '540x270#',
    large_2_1: '960x480#',
    small_3_1: '540x180#',
    large_3_1: '960x320#',
    small_3_4: '540x720#',
    large_3_4: '960x1280#',
    small_original: '540x540>',
    large_original: '960x960>',

    convert_options: {
      thumb: '-quality 75 -strip',
      small_1_1: '-quality 75 -strip',
      large_1_1: '-quality 75 -strip',
      small_4_3: '-quality 75 -strip',
      large_4_3: '-quality 75 -strip',
      small_2_1: '-quality 75 -strip',
      large_2_1: '-quality 75 -strip',
      small_3_1: '-quality 75 -strip',
      large_3_1: '-quality 75 -strip',
      small_1_4: '-quality 75 -strip',
      large_1_4: '-quality 75 -strip',
      small_original: '-quality 75 -strip',
      large_original: '-quality 75 -strip'
    }
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

  def image_url
    size = 'small_' + image_size
    ap size.to_sym
    image.url(size.to_sym)
    # source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    # return false if source.ends_with?('/missing.png')
    # source

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

  def self.image_ratio
    [
      ['1:1', '1_1'],
      ['4:3', '4_3'],
      ['2:1', '2_1'],
      ['4:1', '4_1'],
      ['3:4', '3_4'],
      ['original', 'original']
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
