class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def unused?
    return false if secret.nil?
    #update(secret: nil)
    true
  end
end

# http://localhost:3000/api/v1/epaper_verification?secret=4f047525-4c57-4114-8954-2a913037192a