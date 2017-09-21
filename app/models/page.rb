# Dynamic page to hold content
class Page < ApplicationRecord
  belongs_to :user
  has_many :page_rows
  has_attached_file :body_background
  has_attached_file :body_background, styles: {
    thumb: '90x100>'
  }
  validates_attachment_content_type :body_background, content_type: %r{\Aimage\/.*\Z}
  before_validation { body_background.clear if delete_body_background == '1' }
  attr_accessor(
    :delete_body_background
  )

  LOCALES = %w[da en].freeze

  scope :active, -> { where(active: true) }

  def ordered_page_rows
    page_rows.order('position ASC')
  end

  def first_page_row
    ordered_page_rows.first
  end

  def self.locales
    LOCALES.map { |locale| [I18n.t(locale), locale] }
  end

  def author_name
    user.nil? ? '' : user.name
  end

  def self.menu_collection
    [
      [I18n.t('not_in_any_menus'), 'not_in_any_menus'],
      [I18n.t('menu_bar'), 'menu_bar']
    ]
  end

  def self.for_menu(menu_id)
    active.where(locale: I18n.locale.to_s, menu_id: menu_id)
  end

  def self.front_page
    page_id = Admin::SystemSetup.landing_page_id
    Page.where(id: page_id)
  end

  def footer
    @footer = Admin::Footer.find_by(id: footer_id)
  end

  # rubocop:disable Metrics/AbcSize
  def deletable?
    return false if Admin::SystemSetup.where(locale: locale, landing_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, subscription_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, post_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, welcome_page_id: id).any?
    true
  end

  def background_url
    source = 'https://s3.eu-central-1.amazonaws.com' + body_background.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/row_1_background/missing.png'
      source = nil
    end
    source
  end

  def body_style
    style =
      case layout
      when 'hawaii', 'georgia', 'idaho', 'illinois', 'iowa'
        "background: url(#{background_url});background-size: cover;"
      else
        ''
      end
    style
  end
end
