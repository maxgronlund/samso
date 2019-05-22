# frozen_string_literal: true

# show weather from DMI
class Admin::MostPopularModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns
#
  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::MostPopularModule',
      moduleable_id: id
    )
  end

  def self.posts
    blog_post_ids =
      BlogPostStat
      .where(find_condition, time_range)
      .order(views: :desc)
      .first(5)
      .pluck(:admin_blog_post_id)
    Admin::BlogPost.where(id: blog_post_ids)
  end

  def self.find_condition
    'start_date <= :today AND start_date >= :one_week_ago'
  end

  def self.time_range
    {
      today: Time.zone.now,
      one_week_ago: Time.zone.now - 20.week
    }
  end
end
