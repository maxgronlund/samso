# frozen_string_literal: true

# access codes for epapers
class EPaperToken < ApplicationRecord
  belongs_to :user, counter_cache: true

  def grand_access?
    return false if secret.nil? && created_at > Time.now + 1.minute

    update(secret: nil)
    true
  end
end
