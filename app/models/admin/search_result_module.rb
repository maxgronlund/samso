# frozen_string_literal: true

# show weather from DMI
class Admin::SearchResultModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::SearchResultModule',
      moduleable_id: id
    )
  end
end
