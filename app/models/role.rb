class Role < ApplicationRecord
  MEMBER = 'member'
  ADMIN  = 'admin'
  belongs_to :user
end
