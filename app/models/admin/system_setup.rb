# frozen_string_literal: true

# system setup
class Admin::SystemSetup < ApplicationRecord
  attr_accessor :delete_logo
  has_attached_file :logo, styles: { thumb: '222x22#', original: '1110x143#' }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  before_validation { logo.clear if delete_logo == '1' }

  validates_with Admin::SystemSetup::Validator

  def landing_page
    Page.find_by(locale: locale, id: landing_page_id)
  end

  def search_page
    Page.find_by(locale: locale, id: search_page_id)
  end

  def subscription_page
    Page.find_by(locale: locale, id: subscription_page_id)
  end

  # usage Admin::SystemSetup.clear_page_cache
  def self.clear_page_cache
    Page.find_each(&:touch)
  end

  # Admin::SystemSetup.subscription_module
  def self.subscription_module
    Admin::SubscriptionModule
      .where(locale: I18n.locale)
      .first_or_create(locale: I18n.locale)
  end

  # def default_subscription_type
  #   Admin::SubscriptionType.find_by(id: admin_subscription_type_id)
  # end
end
