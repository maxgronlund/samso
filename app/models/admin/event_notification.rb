class Admin::EventNotification < ApplicationRecord
  serialize :metadata, Hash

  def pending?
    state == 'pending'
  end
end
