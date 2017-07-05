# Joyn a custom section to a pave section slot
class PageModule < ApplicationRecord
  belongs_to :page
  belongs_to :moduleable, polymorphic: true, dependent: :destroy
end
