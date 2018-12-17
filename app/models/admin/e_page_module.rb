# frozen_string_literal: true

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
end
