# frozen_string_literal: true

# Post in the blog
class Admin::BlogPost < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name    "articles-#{Rails.env}"
  document_type 'post'

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'danish', type: 'text'
      indexes :body, analyzer: 'danish', type: 'text'
      indexes :signature, analyzer: 'danish', type: 'text'
      indexes :subtitle, analyzer: 'danish', type: 'text'
      indexes :teaser, analyzer: 'danish', type: 'text'
    end
  end

  attr_accessor :delete_image, :page_id
  belongs_to :blog, class_name: 'Admin::Blog', counter_cache: true, optional: true
  belongs_to :user, class_name: 'User', counter_cache: true, optional: true
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>',
    large: '770x770>',
    full_size: '1110x1110>'
  }

  validates :body, presence: true unless Rails.env == 'test'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  before_validation { image.clear if delete_image == '1' }
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :newsletter_posts, class_name: 'Admin::NewsletterPost', foreign_key: 'admin_blog_post_id'
  has_many :newsletters, through: :newsletter_posts, source: 'admin_newsletter'

  LAYOUTS =
    [
      [I18n.t('blog_post.image_top'), 'image_top'],
      [I18n.t('blog_post.image_left'), 'image_left'],
      [I18n.t('blog_post.image_right'), 'image_right']
    ].freeze

  # rubocop:disable Metrics/MethodLength
  def self.elasticsearch(query)
    __elasticsearch__.search(
      query: {
        multi_match: {
          query: query,
          fields: ['signature^20', 'title^10', 'teaser^5', 'subtitle^5', 'body']
        }
      },
      highlight: {
        pre_tags: ['<em class="label-highlight">'],
        post_tags: ['</em>'],
        fields: {
          signature: { number_of_fragments: 1 },
          title: { number_of_fragments: 1 },
          teaser: { number_of_fragments: 1 },
          subtitle: { number_of_fragments: 1 },
          body: { fragment_size: 145 }
        }
      }
    )
  end
  # rubocop:enable Metrics/MethodLength

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
    update_attributes(views: views + 1) unless updated_at > DateTime.now - 0.5.seconds
  rescue
  end
  # rubocop:enable Lint/HandleExceptions

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

  def build_video_url
    return youtube_video_url if video_url.include?('https://youtu.be/')

    video_url
  end

  def youtube_video_url
    src = '<iframe width="560" height="315" src="https://www.youtube.com/embed/'
    src += video_url.split('https://youtu.be/').last
    src + '" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>'
  end

  def self.all_posts
    Admin::BlogPost
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end
end
