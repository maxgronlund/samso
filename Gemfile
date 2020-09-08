# touched
source 'https://rubygems.org'
ruby "2.5.1"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3.2'
# Use postgres as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'
gem 'sassc'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'awesome_print'
# gem 'elasticsearch-model', '~> 6.0.0'
# gem 'elasticsearch-rails', '~> 6.0.0'
gem 'searchkick'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'font-awesome-sass'
gem 'glyphicons-rails'
gem 'jquery-rails'
gem 'sendgrid-ruby'
gem 'slim-rails'
gem 'simple_form'
gem 'paperclip'
gem 'airbrake'
# gem 'aws-sdk', '~> 2.3'
gem 'aws-sdk-s3', '~> 1.0.0.rc2'
# gem 'rails_autoscale_agent'
# gem 'httparty'
# gem "wysiwyg-rails"
gem "rails_autoscale_agent"
gem 'newrelic_rpm'
gem "rack-timeout"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', git: 'git://github.com/stympy/faker.git', branch: 'master'
  gem 'rubocop-faker'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'cucumber-rails', '1.8.0', require: false
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  #gem 'chromedriver-helper'
  gem 'webdrivers', '~> 3.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
