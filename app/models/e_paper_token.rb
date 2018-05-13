class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def used?
    return true if secret.nil?
    update(secret: nil)
    false
  end
end