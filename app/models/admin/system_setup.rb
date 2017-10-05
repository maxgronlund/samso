# system setup
class Admin::SystemSetup < ApplicationRecord
  def landing_page
    Page.find_by(locale: locale, id: landing_page_id)
  end

  def post_page
    Page.find_by(locale: locale, id: post_page_id)
  end

  def subscription_page
    Page.find_by(locale: locale, id: subscription_page_id)
  end

  def welcome_page
    Page.find_by(locale: locale, id: welcome_page_id)
  end

  # usage Admin::SystemSetup.clear_page_cache
  def self.clear_page_cache
    Page.find_each(&:touch)
  end
end
