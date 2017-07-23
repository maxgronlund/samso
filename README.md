# README

This README would normally document whatever steps are necessary to get the
application up and running.

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
  $ heroku run --app samso rake page:build_subscription_pages
  $ heroku run --app samso rake page:build_front_pages
  $ heroku run --app samso rake page:build_post_pages

* How to run the test suite
  $ rake

* Services (job queues, cache servers, search engines, etc.)
  $ heroku logs --tail --app samso

* Deployment instructions
  $ git push origin master

* console on production
  $ heroku run rails console --app samso

* Huray ported


