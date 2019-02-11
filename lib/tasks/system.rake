namespace :system do
  # usage
  # $ rake system:setup
  desc 'build essential pages'
  task setup: :environment do
    pages =
      [
        { locale: 'en', translation: 'English', front_page: 'Front page', subscription: 'Subscription' },
        { locale: 'da', translation: 'Dansk', front_page: 'Forside', subscription: 'Abonnement' }
      ]
    ActiveRecord::Base.transaction do
      pages.each do |page|
        footer = build_footer(page)
        landing_page = build_page(page[:front_page], footer.id, page[:locale])
        suscription_page = build_page(page[:subscription], footer.id, page[:locale])

        build_system_setup(page, landing_page, suscription_page)
      end
      create_system_messages
      create_search_pages
    end
  end

  desc 'build system messages'
  task build_system_messages: :environment do
    create_system_messages
  end

  private

  def build_footer(locale)
    params =
      {
        title: 'Footer',
        locale: locale[:locale]
      }
    Admin::Footer.where(params).first_or_create(params)
  end

  # rubocop:disable Metrics/MethodLength
  def create_search_pages
    pages_options =
      [
        { locale: 'en', name: 'Search results' },
        { locale: 'da', name: 'Søge resultater' }
      ]
    pages_options.each do |page_options|
      footer = build_footer(page_options)
      page =
        build_page(
          page_options[:name],
          footer.id,
          page_options[:locale]
        )
      system_setup =
        Admin::SystemSetup
        .find_by(locale: page_options[:locale])
      system_setup.update(search_page_id: page.id)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def build_page(name, footer_id, locale)
    params =
      {
        title: name,
        menu_title: name,
        menu_id: 'not_in_any_menus',
        active: true,
        locale: locale,
        admin_footer_id: footer_id
      }
    page = Page.where(params).first_or_initialize(params)
    page.save!(validate: false)
    page
  end

  def build_system_setup(page, landing_page, suscription_page)
    params =
      {
        locale: page[:locale],
        locale_name: page[:translation],
        landing_page_id: landing_page.id,
        subscription_page_id: suscription_page.id,
        maintenance: false,
        administrator_email: 'admin@example.com'
      }
    Admin::SystemSetup.where(params).first_or_create(params)
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/LineLength
  def create_system_messages
    messages = [
      { title: 'velkommen', body: '', identifier: 'welcome', locale: 'da' },
      { title: 'welcome', body: '', identifier: 'welcome', locale: 'en' },
      { title: 'Reset password link er sendt', body: '', identifier: 'resend_password', locale: 'da' },
      { title: 'Reset password link is send', body: '', identifier: 'resend_password', locale: 'en' },
      { title: 'Nyt password', body: '', identifier: 'new_password_email', locale: 'da' },
      { title: 'Indsend læserbrev', body: '', identifier: 'letter_to_the_edditors', locale: 'da' },
      { title: 'New password', body: '', identifier: 'new_password_email', locale: 'en' },
      { title: 'Bekræfte email', body: '', identifier: 'confirm_email_email', locale: 'da' },
      { title: 'Confirm email', body: '', identifier: 'confirm_email_email', locale: 'en' },
      { title: 'Din konto er oprettet', body: 'Der er blevet sendt en konfirmations link til din email', identifier: 'thanks_for_signing_up', locale: 'da' },
      { title: 'Your account is created', body: 'A confirmation email is send to your email', identifier: 'thanks_for_signing_up', locale: 'en' }
    ]
    messages.each do |message|
      Admin::SystemMessage
        .where(identifier: message[:identifier], locale: message[:locale])
        .first_or_create(message)
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/LineLength
end
