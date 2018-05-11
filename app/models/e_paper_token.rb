class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def unused?
    return false if secret.nil?
    update(secret: nil)
    true
  end
end
