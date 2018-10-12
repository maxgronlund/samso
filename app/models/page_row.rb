# a horizontal collections of columns
class PageRow < ApplicationRecord
  attr_accessor :preset, :delete_background_image, :nr_cols
  belongs_to :page, counter_cache: true
  has_many :page_cols, dependent: :destroy

  has_attached_file :background_image, styles: {
    thumb: '160x40#'
  }

  validates_attachment_content_type :background_image, content_type: %r{\Aimage\/.*\Z}
  before_validation { background_image.clear if delete_background_image == '1' }

  LAYOUTS = [
    %w[Normal row],
    ['align-items-start', 'row align-items-start'],
    ['align-items-center', 'row align-items-center'],
    ['align-items-end', 'row align-items-end'],
    ['justify-content-start', 'row justify-content-start'],
    ['justify-content-center', 'justify-content-center'],
    ['justify-content-end', 'justify-content-end'],
    ['justify-content-around', 'row justify-content-around'],
    ['justify-content-between', 'row justify-content-between']
  ].freeze

  PRESETS = [
    %w[12 12],
    %w[6-6 6_6],
    %w[8-4 8_4],
    %w[4-8 4_8],
    %w[9-3 9_3],
    %w[3-9 3_9],
    %w[4-4-4 4_4_4],
    %w[3-6-3 3_6_3],
    %w[3-3-3-3 3_3_3_3],
    %w[2-2-2-2-2-2 2_2_2_2_2_2]
  ].freeze

  def style
    page_style = ''
    page_style += "background-image: url(#{background_image_url});" if background?
    page_style += "padding: #{padding_top}px 0 #{padding_bottom}px;"
    page_style + "background-color: #{background_color}"
  end

  def ordered_page_cols
    page_cols.order(:index)
  end

  private

  def first_page_row?
    page.first_page_row == self
  end

  def background_image_url
    return '' unless background?
    background_image.url
  end

  def background?
    !background_image_file_size.nil?
  end
end
