class Role < ApplicationRecord
  MEMBER = 'member'
  ADMIN  = 'admin'
  EDITOR = 'editor'
  SUPER_ADMIN = 'super_admin'
  ROLES = [ADMIN, MEMBER, EDITOR]
  belongs_to :user
end
