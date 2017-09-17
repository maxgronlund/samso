# one column form bootstrap
class PageCol < ApplicationRecord
  belongs_to :page_row, counter_cache: true
  has_many :page_col_modules, dependent: :destroy

  def page
    page_row.page
  end
end
