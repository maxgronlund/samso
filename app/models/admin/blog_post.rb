# frozen_string_literal: true

# Post in the blog
class Admin::BlogPost < ApplicationRecord

  searchkick

  attr_accessor :delete_image, :page_id
  belongs_to :blog, class_name: 'Admin::Blog', counter_cache: true, optional: true
  belongs_to :user, class_name: 'User', counter_cache: true, optional: true
  has_one :blog_post_stat, foreign_key: :admin_blog_post_id, dependent: :destroy
  has_attached_file :image,
    styles: {
      medium: '300x300>',
      thumb: '100x100>',
      large: '770x770>',
      full_size: '1110x1110>'
    },
    convert_options: {
      medium: "-quality 75 -strip",
      thumb: "-quality 75 -strip",
      large: "-quality 75 -strip",
      full_size: "-quality 75 -strip"
    }

  has_attached_file :photo,
  :styles => { :thumb => "100x100#" }, :convert_options => {:thumb => "-quality 75 -strip" }

  validates :body, presence: true unless Rails.env == 'test'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  before_validation { image.clear if delete_image == '1' }
  has_many :comments, foreign_key: "admin_blog_post_id", class_name: 'Comment', dependent: :destroy
  has_many(
    :blog_post_images,
    dependent: :destroy,
    class_name: 'Admin::BlogPostImage',
    foreign_key: 'admin_blog_post_id'
  )
  has_many(
    :blog_post_contents,
    dependent: :destroy,
    class_name: 'Admin::BlogPostContent',
    foreign_key: 'admin_blog_post_id'
  )

  has_many :newsletter_posts, class_name: 'Admin::NewsletterPost', foreign_key: 'admin_blog_post_id'
  has_many :newsletters, through: :newsletter_posts, source: 'admin_newsletter'

  LAYOUTS =
    [
      [I18n.t('blog_post.image_top'), 'image_top'],
      [I18n.t('blog_post.image_left'), 'image_left'],
      [I18n.t('blog_post.image_right'), 'image_right']
    ].freeze



  def comments?
    !comments_count.zero?
  end

  def show_page
    blog.show_page
  end

  # def page
  #   blog_module.page
  # end

  def image_url(size)
    image.url(size)
  end

  def clear_page_cache
    blog.clear_cache_on_pages
  end

  # rubocop:disable Lint/HandleExceptions
  def shown!
    secure_blog_post_stat.shown!
  end
  # rubocop:enable Lint/HandleExceptions

  def views
    secure_blog_post_stat.views
  end

  def views_last_seven_days
    secure_blog_post_stat.views_last_seven_days
  end

  def to_param
    "#{id} #{title}".parameterize
  end

  def secure_blog_post_stat
    blog_post_stat.presence ||
      BlogPostStat.create(
        admin_blog_post_id: self.id,
        views: 1,
        start_date: Time.zone.now
      )
  end

  def author_name
    return signature unless signature.blank?
    return user.name if user

    ''
  end

  def category_name
    blog.title
  end

  def build_video_url
    return youtube_video_url if video_url.include?('https://youtu.be/')
    # return vimeo_video_url if video_url.include?('https://vimeo.com')

    video_url
  end

  def youtube_video_url
    src = '<iframe width="560" height="315" src="https://www.youtube.com/embed/'
    src += video_url.split('https://youtu.be/').last
    src + '" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>'
  end

#   def vimeo_video_url
#     src = '<iframe src="https://player.vimeo.com/video/'
#     src += video_url.split

#     <iframe src="https://player.vimeo.com/video/460211281" width="640" height="360" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>
# <p><a href="https://vimeo.com/460211281">9B3F5F8D-8F2B-4E34-BCE7-580CF6B9FDC8</a> from <a href="https://vimeo.com/user123623317">Max Gr&oslash;nlund</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
#   end

  def images
    blog_post_images.order(:position)
  end

  def last_image
    images.last
  end

  def next_image_position
    return 0 unless last_image.present?

    last_image.position + 10
  end

  def contents
    blog_post_contents.order(:position)
  end

  def last_content
    contents.last
  end

  def next_content_position
    return 10 unless last_content.present?

    last_content.position + 10
  end

  def self.all_posts
    Admin::BlogPost
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end
end
