class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def unused?
    return false if secret.nil?
    #update(secret: nil)
    true
  end
end

# http://localhost:3000/api/v1/epaper_verification?secret=c1bcbf97-4183-4cfb-985e-1a1ab918910c