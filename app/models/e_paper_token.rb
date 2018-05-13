class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def grand_access?
    return true if secret.nil? && created_at > Time.now - 1.minute
    update(secret: nil)
    false
  end
end