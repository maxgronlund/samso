# show weather from DMI
class Admin::EPageModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::EPageModule',
      moduleable_id: id
    )
  end

  def validation_url(current_user)
    return link if current_user.nil?
    valid_url(current_user)
  end

  private

  def valid_url(current_user)
    uuid = SecureRandom.uuid
    current_user
      .e_paper_tokens
      .create(uuid: uuid)
    #link + "?secret=#{uuid}&date=2018-05-03&edition=SM1"

    "http://login.e-pages.dk/samsoposten/open/?secret=#{uuid}&date=2018-05-03&edition=SM1"
  end
end
