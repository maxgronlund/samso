# system setup
class Admin::SystemSetup < ApplicationRecord
  has_many :posts, as: :postable

  # usage Admin::SystemSetup.maintenance_content
  def self.maintenance_content(position)
    Admin::SystemSetup
      .first
      .posts
      .where(
        identifier: [
          '90acf22f-ccaa-4169-b873-24c36e0b8b8',
          '80edd4a2-fe45-423a-9c17-35b87feb50c',
          '84b340d3-fad6-412a-a24b-aab34321b6fa',
          'e9e83f7d-196e-40e8-bfab-33ac7d3e59d7'
        ]
      )
      .where(position: position)
      .first
  end

  def self.landing_page
    system_setup = Admin::SystemSetup.first
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
end
