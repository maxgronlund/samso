namespace :system do
  # usage
  # $ rake system:setup
  desc 'build essential pages'
  task setup: :environment do
    @result = { status: :ok, reason: '' }
    locales =
      [
        { locale: 'en', translation: 'English', name: 'Front page' },
        { locale: 'da', translation: 'Dansk', name: 'Forside' }
      ]
    ActiveRecord::Base.transaction do
      locales.each do |locale|
        footer = build_footer(locale)
        landing_page = build_landing_page(locale, footer.id) unless @result[:status] == :error
        build_system_setup(locale, landing_page.id) unless @result[:status] == :error
      end
      create_system_messages
      raise ActiveRecord::Rollback if @result[:status] == :error
    end
  end

  private

  def build_footer(locale)
    params =
      {
        title: 'Footer',
        locale: locale[:locale]
      }
    Admin::Footer.where(params).first_or_create(params)
  rescue
    @result = { status: :error, reason: 'Unable to build footer' }
  end

  def build_landing_page(locale, footer_id)
    user = User.super_admin
    params =
      {
        locale: locale[:locale],
        title: locale[:name],
        menu_title: locale[:name],
        menu_id: 'not_in_any_menus',
        active: true,
        user_id: user.id,
        admin_footer_id: footer_id
      }
    Page.where(params).first_or_create(params)
  rescue
    @result = { status: :error, reason: 'Unable to build landing page' }
  end

  def build_system_setup(locale, page_id)
    params =
      {
        locale: locale[:locale],
        locale_name: locale[:translation],
        landing_page_id: page_id,
        maintenance: false
      }
    Admin::SystemSetup.where(params).first_or_create(params)
  rescue
    @result = { status: :error, reason: 'Unable to  build system setup' }
  end

  def create_system_messages
    messages = [
      { title: 'velkommen', body: '', identifier: 'welcome', locale: 'da' },
      { title: 'welcome', body: '', identifier: 'welcome', locale: 'en' },
      { title: 'Reset password link er sendt', body: '', identifier: 'resend_password', locale: 'da' },
      { title: 'Reset password link is send', body: '', identifier: 'resend_password', locale: 'en' },
      { title: 'Nyt password', body: '', identifier: 'new_password_email', locale: 'da' },
      { title: 'New password', body: '', identifier: 'new_password_email', locale: 'en' },
      { title: 'Bekræfte email', body: '', identifier: 'confirm_email_email', locale: 'da' },
      { title: 'Confirm email', body: '', identifier: 'confirm_email_email', locale: 'en' },
      { title: 'Din konto er oprettet', body: 'Der er blevet sendt en konfirmations link til din email', identifier: 'thanks_for_signing_up', locale: 'da' },
      { title: 'Your account is created', body: 'A confirmation email is send to your email', identifier: 'thanks_for_signing_up', locale: 'en' }
    ]
    messages.each do |message|
      Admin::SystemMessage
        .where(identifier: message[:identifier], locale: message[:localt])
        .first_or_create(message)
    end
  end
end
