namespace :system_setup do
  # usage
  # rake system_setup:build_defaults
  desc 'build locale system setup'
  task build_defaults: :environment do
    system_setup = Admin::SystemSetup.first_or_initialize
    system_setup.locale = 'da'
    system_setup.locale_name = 'Dansk'
    system_setup.save

    system_setup = Admin::SystemSetup.where(locale: 'en').first_or_initialize
    system_setup.locale = 'en'
    system_setup.locale_name = 'English'
    system_setup.save
  end
end
