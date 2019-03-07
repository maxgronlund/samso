# frozen_string_literal: true

class Role < ApplicationRecord
  MEMBER = 'member'
  ADMIN  = 'admin'
  EDITOR = 'editor'
  SUPER_ADMIN = 'super_admin'
  ROLES = [ADMIN, MEMBER, EDITOR]
  belongs_to :user

  TRANSLATED_ROLES = [
    [I18n.t('role.' + MEMBER), MEMBER],
    [I18n.t('role.' + ADMIN), ADMIN],
    [I18n.t('role.' + EDITOR), EDITOR]
  ]
end
