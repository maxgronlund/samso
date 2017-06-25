class Role < ApplicationRecord
  MEMBER = 'member'
  ADMIN  = 'admin'
  SUUPER_ADMIN = 'super_admin'
  ROLES = [ADMIN, MEMBER]
  belongs_to :user
end
