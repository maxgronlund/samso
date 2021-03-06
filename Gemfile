source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.x'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Custom gems used exclucive for the samso project
gem 'coffee-rails'
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
gem 'aws-sdk-s3', '~> 1.0.0.rc2'
gem "rails_autoscale_agent"
# gem "rack-timeout"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker', git: 'git://github.com/stympy/faker.git', branch: 'master'
  gem 'rubocop-faker'
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'


  gem 'cucumber-rails', '1.8.0', require: false
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'database_cleaner'
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara'
  #gem 'chromedriver-helper'
  # gem 'webdrivers', '~> 3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
