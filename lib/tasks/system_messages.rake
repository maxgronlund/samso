namespace :system_messages do
  # usage
  # rake system_messages:build_defaults
  desc 'build locale system setup'
  task build_defaults: :environment do
    messages = [
      { title: 'velkommen', body: '', identifier: 'welcome', locale: 'da' },
      { title: 'welcome', body: '', identifier: 'welcome', locale: 'en' },
      { title: 'Reset password link er sendt', body: '', identifier: 'resend_password', locale: 'da' },
      { title: 'Reset password link is send', body: '', identifier: 'resend_password', locale: 'en' },
      { title: 'Nyt password', body: '', identifier: 'new_password_email', locale: 'da' },
      { title: 'New password', body: '', identifier: 'new_password_email', locale: 'en' },
      { title: 'Bekræfte email', body: '', identifier: 'confirm_email_email', locale: 'da' },
      { title: 'Confirm email', body: '', identifier: 'confirm_email_email', locale: 'en' }
    ]
    messages.each do |message|
      Admin::SystemMessage
        .where(identifier: message[:identifier], locale: message[:localt])
        .first_or_create(message)
    end
  end
end
