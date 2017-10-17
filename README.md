# README

Shoe-lace

A framework for building custom web-app.
it trades explicity over implicity
It's based on Bootstrap
It supports five role
It's easy to expand

Guests
Members
Editors
Managers
Administrators
Super administrator

An user can be granded one or many roles

For developers
The core is super simple and easy to understand.
There is no hidden framework to understand.
All that's happens is a set of files is installed
As a developer you will find no magic code no DSL to learn
it's easy to understand and expand, you deside what features
to include so ther is no dead code to make noice.

As a administrator you can build pages in a minimalistic wordpress / drupal style
Theme the layout without any CSS/ HTML skils, and create subscriptions models that
fits the buisness needs out of the box

As an editor you can add / edit content without accessing the admin backend



Things you may want to cover:

* Ruby version
  2.4.1

* System dependencies

* Configuration
  Os X / Ubunto

* Database creation
  rake db:create

* Database initialization
  rake db:seed

* Database migration
  $ heroku run --app samso rake db:migrate
  $ heroku logs --tail --app samso

* Tasks

  $ heroku run --app samso rake db:migrate
  $ heroku run --app samso rake db:seed
  $ heroku run --app samso rake system:setup


* How to run the test suite
  # Run only model specs
  $ bundle exec rspec spec/models

  # Run only specs for AccountsController
  $ bundle exec rspec spec/controllers/accounts_controller_spec.rb

  # Run only spec on line 8 of AccountsController
  $ bundle exec rspec spec/controllers/accounts_controller_spec.rb:8


* Services (job queues, cache servers, search engines, etc.)
  $ heroku logs --tail --app samso

* Deployment instructions
  $ git push origin master

* console on production
  $ heroku run rails console --app samso
  $ PgSearch::Multisearch.rebuild(User)
  $ UserNotifierMailer.send_signup_email(user).deliver


* Huray ported

[![Build Status](https://semaphoreci.com/api/v1/synthmax/samso/branches/master/badge.svg)](https://semaphoreci.com/synthmax/samso)
