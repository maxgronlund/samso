# frozen_string_literal: true

# one column form bootstrap
class PageCol < ApplicationRecord
  belongs_to :page_row, counter_cache: true
  has_many :page_col_modules, dependent: :destroy

  def page
    page_row.page
  end

  def ordered_page_col_modules
    page_col_modules.order('position DESC')
  end

  def next_page_col_module_position
    return 0 if ordered_page_col_modules.empty?

    ordered_page_col_modules.first.position + 10
  end
end
