class PageRowModule < ApplicationRecord
  belongs_to :page_row
  belongs_to :moduleable, polymorphic: true
end
