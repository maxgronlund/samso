# frozen_string_literal: true

# internal comments
class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :admin_blog_post, counter_cache: true, class_name: 'Admin::BlogPost'
  has_many :weekly_comments, dependent: :destroy
  validates :comment, presence: true

  STATES = [
    ['Normal', 'default'],
    ['Flagged', 'reported'],
    ['Fjernet', 'removed'],
    ['Godkendt', 'apporved']
  ].freeze

  def default?
    state == 'default'
  end

  def show?(current_user)
    return true if current_user == user
    return true if default?
    return true if current_user.administrator?

    false
  end

  def removed?
    state == 'removed'
  end

  def account_name
    user.name
  end

  def show_hidden_label?(current_user)
    return false unless removed?
    return true if current_user.administrator? && removed?
    false
  end

  def edditable?(edditor)
    return false if edditor.nil?
    return true if edditor.administrator?

    edditor == user
  end

  def commentable
    admin_blog_post
  end
end
