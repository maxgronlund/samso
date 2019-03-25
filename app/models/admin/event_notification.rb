class Admin::EventNotification < ApplicationRecord
  serialize :metadata, Hash
end
