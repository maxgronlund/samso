# frozen_string_literal: true

# Module for carousel
class Admin::CarouselModule < ApplicationRecord
  include PageColConcerns
  has_many :page_col_modules, as: :moduleable
  has_many :slides, class_name: 'Admin::CarouselSlide', dependent: :destroy

  def self.image_sizes
    [
      [I18n.t('big'), '12_col_4x1'],
      [I18n.t('medium'), '9_coll_3x1'],
      [I18n.t('small'), '6_coll_2x1']
    ]
  end
end
