# join a modyle to a col
class PageColModule < ApplicationRecord
  belongs_to :page_col
  belongs_to :moduleable, polymorphic: true
  scope :ordered, -> { order('position ASC') }

  def modulable_path
    moduleable.class.name.underscore.gsub('admin/', '') + 's/show'
  end

  def modulable_edit_path
    'admin/' + moduleable.class.name.underscore + 's/edit'
  end

  def admin_modulable_path
    'admin/' + moduleable.class.name.underscore.gsub('admin/', '') + 's/show'
  end
end
