# join a modyle to a col
class PageColModule < ApplicationRecord
  belongs_to :page_col
  belongs_to :moduleable, polymorphic: true

  def modulable_path
    moduleable.class.name.underscore + 's/show'
  end

  def modulable_edit_path
    'admin/' + moduleable.class.name.underscore + 's/edit'
  end
end
