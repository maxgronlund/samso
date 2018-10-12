# Post in the blog
class Admin::BlogPost < ApplicationRecord
  include PgSearch

  attr_accessor :delete_image, :page_id
  belongs_to :blog, class_name: 'Admin::Blog', counter_cache: true, optional: true
  belongs_to :user, class_name: 'User', counter_cache: true, optional: true
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>',
    large: '770x770>',
    full_size: '1110x1110>'
  }

  pg_search_scope :search_by_content, against: %i[title body subtitle teaser signature]
  multisearchable against: %i[title body subtitle teaser signature]
  pg_search_scope :search_by_title_or_body, against: %i[title body subtitle teaser signature]

  # pg_search_scope(
  #   :search_by_title_or_body,
  #   against: %i(
  #     title
  #     body
  #     subtitle
  #     signature
  #   ),
  #   using: {
  #     tsearch: {
  #       dictionary: "english",
  #     }
  #   }
  # )

  validates :body, presence: true unless Rails.env == 'test'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  before_validation { image.clear if delete_image == '1' }
  has_many :comments, as: :commentable, dependent: :destroy

  LAYOUTS =
    [
      [I18n.t('blog_post.image_top'), 'image_top'],
      [I18n.t('blog_post.image_left'), 'image_left'],
      [I18n.t('blog_post.image_right'), 'image_right']
    ].freeze

  def show_on_page
    Page.find_by(id: post_page_id) || Page.find_by(locale: I18n.locale)
  end

  def page
    blog_module.page
  end

  def image_url(size)
    image.url(size)
  end

  def clear_page_cache
    blog.clear_cache_on_pages
  end

  def shown!
    update_attributes(views: views + 1) unless updated_at > DateTime.now - 0.5.seconds
  end

  def to_param
    "#{id} #{title}".parameterize
  end

  def author_name
    return signature unless signature.blank?
    return user.name if user
    ''
  end

  def category_name
    blog.title
  end

  def self.all_posts
    Admin::BlogPost
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end
end
