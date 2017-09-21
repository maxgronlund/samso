# raw text to place on a page
class Admin::TextModule < ApplicationRecord
  include PageColConcerns
  has_many :page_col_modules, as: :moduleable
  belongs_to :page, optional: true

  has_attached_file :image, styles: {
    thumb: '64x64#',
    aspect_ratio_1_1: '540x540#',
    aspect_ratio_2_1: '540x270#',
    aspect_ratio_3_1: '540x180#',
    aspect_ratio_4_1: '540x135#',
    aspect_ratio_4_3: '540x405#',
    aspect_ratio_3_4: '540x720#',
    aspect_ratio_original: '540x540>',

    large_default_url: 'style/missing_squarde_image.jpg',

    convert_options: {
      thumb: '-quality 75 -strip',
      aspect_ratio_1_1: '-quality 75 -strip',
      aspect_ratio_2_1: '-quality 75 -strip',
      aspect_ratio_3_1: '-quality 75 -strip',
      aspect_ratio_4_1: '-quality 75 -strip',
      aspect_ratio_4_3: '-quality 75 -strip',
      aspect_ratio_3_4: '-quality 75 -strip',
      aspect_ratio_original: '-quality 75 -strip'
    }
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def image_url
    ap image.url(image_ratio.to_sym)
    image.url(image_ratio.to_sym)
    # source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    # return false if source.ends_with?('/missing.png')
    # source
  end

  def show_link?
    !url.to_s.empty?
  end

  def self.image_styles
    [
      [I18n.t('admin/text_module.full_width'), 'full-width'],
      [I18n.t('admin/text_module.bordered'), 'bordered'],
      [I18n.t('admin/text_module.circle'), 'circle']
    ]
  end

  def self.image_ratio
    [
      [I18n.t('admin/text_module.image.aspect_ratio_1_1'), 'aspect_ratio_1_1'],
      [I18n.t('admin/text_module.image.aspect_ratio_2_1'), 'aspect_ratio_2_1'],
      [I18n.t('admin/text_module.image.aspect_ratio_3_1'), 'aspect_ratio_3_1'],
      [I18n.t('admin/text_module.image.aspect_ratio_4_1'), 'aspect_ratio_4_1'],
      [I18n.t('admin/text_module.image.aspect_ratio_4_3'), 'aspect_ratio_4_3'],
      [I18n.t('admin/text_module.image.aspect_ratio_3_4'), 'aspect_ratio_3_4'],
      [I18n.t('admin/text_module.image.aspect_ratio_original'), 'aspect_ratio_original']
    ]
  end

  def self.link_layouts
    [
      [I18n.t('admin/text_module.link_layouts.text_left'), 'text_left'],
      [I18n.t('admin/text_module.link_layouts.text_center'), 'text_center'],
      [I18n.t('admin/text_module.link_layouts.text_right'), 'text_right'],
      [I18n.t('admin/text_module.link_layouts.button_left'), 'button_left'],
      [I18n.t('admin/text_module.link_layouts.button_center'), 'button_center'],
      [I18n.t('admin/text_module.link_layouts.button_right'), 'button_right']
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
      [I18n.t('admin/text_module.show_to.all'), 'all'],
      [I18n.t('admin/text_module.show_to.guests'), 'guests'],
      [I18n.t('admin/text_module.show_to.members'), 'members']
    ]
  end

  def no_link?
    page_id.nil? && url.empty?
  end

  def link?
    !no_link?
  end

  def link_with_text?
    link? && !url_text.blank?
  end
end
