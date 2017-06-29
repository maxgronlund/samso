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

unless Admin::SystemSetup.first
  Admin::SystemSetup.create(
    maintenance: true
  )
end

posts = [
  {
    title: 'SAMSO.DK BLIVER OPDATERET',
    body: 'Vi arbejder på sagen og er tilbage hurtigst muligt.',
    identifier: '90acf22f-ccaa-4169-b873-24c36e0b8b8',
    position: 0,
    contentable_id: Admin::SystemSetup.first.id,
    contentable_type: 'Admin::SystemSetup'
  },
  {
    title: 'HVORFOR BLIVER SAMSO.DK OPDATERET?',
    body: 'It indicates a synchronic distortion in the areas emanating triolic waves',
    identifier: '80edd4a2-fe45-423a-9c17-35b87feb50c',
    position: 1,
    contentable_id: Admin::SystemSetup.first.id,
    contentable_type: 'Admin::SystemSetup'
  },
  {
    title: 'HVOR LANG TID TAGER DET?',
    body: 'The cerebellum, the cerebral cortex, the brain stem,  the entire nervous system has been depleted of electrochemical energy.',
    identifier: '84b340d3-fad6-412a-a24b-aab34321b6fa',
    position: 2,
    contentable_id: Admin::SystemSetup.first.id,
    contentable_type: 'Admin::SystemSetup'
  },
  {
    title: 'KONTAKT OS',
    body: "I haven't determined if our phaser energy can generate a stable field.",
    identifier: 'e9e83f7d-196e-40e8-bfab-33ac7d3e59d7',
    position: 3,
    contentable_id: Admin::SystemSetup.first.id,
    contentable_type: 'Admin::SystemSetup'
  }
]

posts.each do |post|
  Post
    .where(identifier: post[:identifier])
    .first_or_create(post)
end
