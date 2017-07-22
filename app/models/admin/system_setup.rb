# system setup
class Admin::SystemSetup < ApplicationRecord
  has_many :posts, as: :postable

  def self.landing_page
    system_setup = current
    I18n.locale
    case I18n.locale
    when :da
      page_id = system_setup.da_landing_page_id
      return Page.find_by(id: page_id)
    when :en
      page_id = system_setup.en_landing_page_id
      return Page.find_by(id: page_id)
    end
  end

  # usage Admin::SystemSetup.post_page
  def self.post_page
    system_setup = current
    I18n.locale
    case I18n.locale
    when :da
      page_id = system_setup.da_post_page_id
      return Page.find_by(id: page_id)
    when :en
      page_id = system_setup.en_post_page_id
      return Page.find_by(id: page_id)
    end
  end

  # usage Admin::SystemSetup.subscription_page
  def self.subscription_page
    system_setup = current
    I18n.locale
    case I18n.locale
    when :da
      page_id = system_setup.da_subscription_page_id
      return Page.find_by(id: page_id)
    when :en
      page_id = system_setup.en_subscription_page_id
      return Page.find_by(id: page_id)
    end
  end

  # usage Admin::SystemSetup.current
  def self.current
    Admin::SystemSetup.first_or_create(
      maintenance: false
    )
  end
end
