class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def author_name
    return user.name unless user.nil?
  end
end
