# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.where(
  name: "admin",
  email: "admin@example.com"
).first_or_create(
  name: "admin",
  email: "admin@example.com"
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

if user
  user.password = 'ChangeMe1337'
  user.password_confirmation = 'ChangeMe1337'
  user.save
end
