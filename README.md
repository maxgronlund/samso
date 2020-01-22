[![Build Status](https://semaphoreci.com/api/v1/synthmax/samso/branches/master/badge.svg)](https://semaphoreci.com/synthmax/samso)

# README


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

An user can be granted one or many roles

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

* Database dump
  $ psql samso_development > samso_development

* Database restore
  $ psql samso_development < samso_development
  psql samso_development < /Users/maxgronlund/Documents/rails-projects/samso/latest.dump

* Import categories as csv file and build pages for articles
  rake page:build


* Database migration
  $ heroku run --app samso rake db:migrate


* Logging
  $ heroku logs --tail --app samso

* Tasks

  $ heroku run --app samso rake db:migrate
  $ heroku run --app samso rake db:seed
  $ heroku run --app samso rake blog_posts:update_layout
  $ heroku restart -a samso
  $ heroku run --app samso rake pg_search:multisearch:rebuild[User]
  $ heroku domains:add samso.com
  $ heroku domains:add \*.samso.com


  * download the db
  $ heroku pg:backups:capture --app samso
  $ heroku pg:backups:download --app samso

# install backup from Heroku on localhost
  pg_restore --verbose --clean --no-acl --no-owner -h localhost -U maxgronlund -d samso_development /Users/maxgronlund/Documents/rails-projects/samso/latest.dump

  alternative
  heroku pg:pull postgres://gsrwkvfqdujbtr:e11ea59968cc5bb63b5a695fa722b3efc77474a37d368b41d42749af7f161e82@ec2-54-195-241-106.eu-west-1.compute.amazonaws.com:5432/d3m4k2rgl9urs2 samso_development --app samso


  $ heroku addons:create heroku-postgresql:hobby-basic --app samso

  heroku pg:copy DATABASE_URL HEROKU_POSTGRESQL_MAUVE_URL --app samso
  heroku pg:promote HEROKU_POSTGRESQL_MAUVE_URL --app samso


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
  Make sure to edit a config/secrets.yml file

* console on production
  $ heroku run rails console --app samso
  $ PgSearch::Multisearch.rebuild(User)
  $ UserNotifierMailer.send_signup_email(user).deliver

* building a module
  $ rails g scaffold_module MODULE_NAME (singular)

  in routes
* Huray ported



Admin::BlogPost.__elasticsearch__.delete_index!
Admin::BlogPost.__elasticsearch__.create_index!
Admin::BlogPost.__elasticsearch__.refresh_index!
Admin::BlogPost.__elasticsearch__.import force: true

$ Admin::BlogPost.__elasticsearch__.create_index! √
$ Admin::BlogPost.__elasticsearch__.create_index! force: true
$ Admin::BlogPost.__elasticsearch__.refresh_index! √
$
$ Admin::BlogPost.import force: true



On Heroku
Address.__elasticsearch__.delete_index!
Address.__elasticsearch__.create_index!
Address.__elasticsearch__.refresh_index!
Address.import force: true


start elasticsearch
$ elasticsearch

* maintance
heroku maintenance:on --app samso
heroku maintenance:off --app samso

heroku config:set MAINTENANCE_PAGE_URL=//s3.amazonaws.com/samso-images/maintance.html

* DNS
heroku domains --app samso

* ngrok
./ngrok http 3000


<iframe width="290" height="200" frameborder="0" scrolling="yes" src="http://samsoposten.dk.nt5.unoeuro-server.com/event/visidag.asp"></iframe>


heroku[router]: at=error code=H12 desc="Request timeout" method=GET path="/" host=samso.herokuapp.com request_id=6a28f876-076f-4afb-ab9e-46f5f5f35a63 fwd="195.210.18.10,157.167.45.180" dyno=web.1 connect=0ms service=30000ms status=503 bytes=0 protocol=htt

