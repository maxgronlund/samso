# Dynamic page to hold content
class Page < ApplicationRecord
  has_many :page_rows, dependent: :destroy

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
    @footer = Admin::Footer.find_by(id: admin_footer_id)
  end

  def deletable?
    return false if Admin::SystemSetup.where(locale: locale, landing_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, subscription_page_id: id).any?
    true
  end

  def background_url
    body_background.url
  end

  def background?
    !body_background_file_size.nil?
  end

  def background_color?
    background_color != 'none'
  end

  def body_style
    return '' unless background? || background_color?
    "background: url(#{background_url});background-size: cover; background-repeat: no-repeat; background-color: #{background_color}"
  end
end
