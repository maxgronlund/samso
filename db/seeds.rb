# frozen_string_literal: true

# This file contain all the record creation needed to seed the database with its default values.

user = User.where(
  name: "admin",
  email: "admin@example.com"
).first_or_create(
  name: "admin",
  email: "admin@example.com",
  password: 'ChangeMe1337',
  confirmed_at: Time.zone.now
)

role = Role.where(
  user_id: user.id,
  permission: Role::ADMIN
).first_or_create(
  user_id: user.id,
  permission: Role::ADMIN
)

role = Role.where(
  user_id: user.id,
  permission: Role::SUPER_ADMIN
).first_or_create(
  user_id: user.id,
  permission: Role::SUPER_ADMIN
)

Rake::Task['system:setup'].invoke
Rake::Task['pages:build'].invoke
