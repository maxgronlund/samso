# Newsletter for users where subscribe_to_news is set to true
class Admin::Newsletter < ApplicationRecord
  PENDING = 'pending'.freeze
  IN_SENDING_QUEUE = 'in-sending-queue'.freeze
  SEND = 'send'.freeze

  has_many(
    :newsletter_posts,
    class_name: 'Admin::NewsletterPost',
    foreign_key: 'admin_newsletter_id',
    dependent: :destroy
  )
  has_many :blog_posts, through: :newsletter_posts, source: 'admin_blog_post'

  def pending!
    update(state: PENDING)
  end

  def in_sending_queue!
    update(state: IN_SENDING_QUEUE)
  end

  def send!
    update(state: SEND)
  end

  def in_sending_queue?
    state == IN_SENDING_QUEUE
  end

  def pending?
    state == PENDING
  end

  def send?
    state == SEND
  end
end
