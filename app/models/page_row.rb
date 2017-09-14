class PageRow < ApplicationRecord
  belongs_to :page

  has_attached_file :background_image

  has_attached_file :background_image, styles: {
    thumb: '160x40>'
  }

  LAYOUTS = [
    %w[12 12],
    %w[2-10 2_10]
    # 3_9
    # 4_8
    # 5_7
    # 6_6
    # 7_5
    # 8_4
    # 9_3
    # 10_2
    # 2_2_8
    # 2_3_7
    # 2_4_6
    # 2_5_5
    # 2_6_4
    # 2_7_3
    # 2_8_2
    # 3_3_6
    # 3_4_5
    # 3_5_5
    # 3_6_3
    # 4_2_6
    # 4_3_5
    # 4_4_4
    # 4_5_3
    # 4_6_2
    # 3_3_3_3
    # 3_2_2_2_3
    # 2_2_2_2_2_2
  ].freeze

  def style(index)
    style = "background-image: url(#{background_image_url});"
    style += 'margin-top: 54px;' if index.zero?
    style += "padding: #{padding_top}px 0 #{padding_bottom}px;"
    style + "background-color: #{background_color}"
  end

  private

  def background_image_url
    source = 'https://s3.eu-central-1.amazonaws.com' + background_image.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/page_row/background_image/missing.png'
      source = nil
    end
    source
  end
end
