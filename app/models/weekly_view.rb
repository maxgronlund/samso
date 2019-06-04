class WeeklyView < ApplicationRecord
  belongs_to :blog_post_stat, counter_cache: true
end
