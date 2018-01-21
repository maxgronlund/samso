# frozen_string_literal: true

# show weather from DMI
class Admin::FeaturedPostModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  # belongs_to :blog_module, class_name: 'Admin::BlogModule'
  include PageColConcerns

  FEATURED_POSTS = 'featured_posts'.freeze
  LATEST_NEWS = 'latest_news'.freeze

  CONTENT_TYPES = [
    [I18n.t('featured_post_module.featured_posts'), FEATURED_POSTS],
    [I18n.t('featured_post_module.latest_news'), LATEST_NEWS]
  ].freeze

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::FeaturedPostModule',
      moduleable_id: id
    )
  end

  def posts
    case content_type
    when FEATURED_POSTS
      featured_posts
    when LATEST_NEWS
      latest_news
    end
  end

  private

  def latest_news
    all_posts
      .first(featured_posts_pr_page)
  end

  def featured_posts
    all_posts
      .where(featured: true)
      .first(featured_posts_pr_page)
  end

  def all_posts
    Admin::BlogPost
      .order('start_date DESC')
      .where(
        'start_date <= :today', today: Time.zone.now
      )
  end
end
