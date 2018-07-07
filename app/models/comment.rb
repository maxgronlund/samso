class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def author_name
    user.present? ? user.name : ''
  end

  def edditable?(edditor)
    return false if edditor.nil?
    return true if edditor.administrator?
    edditor == user
  end
end
