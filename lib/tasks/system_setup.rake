namespace :system_setup do
  # usage
  # $ rake system_setup:essentials
  desc 'build essentials'
  task essentials: :environment do
    @result = { status: :ok, reason: '' }
    locales =
      [
        { locale: 'en', translation: 'English', name: 'frone page' },
        { locale: 'da', translation: 'Dansk', name: 'Forside' }
      ]
    ActiveRecord::Base.transaction do
      locales.each do |locale|
        footer = build_footer(locale)
        page = build_landing_page(locale, footer.id) unless @result[:status] == :error
        build_system_setup(locale, page.id) unless @result[:status] == :error
      end
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
  rescue => e
    ap e.message
    ap e.backtrace
    @result = { status: :error, reason: 'Unable to build footer' }
  end

  # rubocop:disable Metrics/MethodLength
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
  rescue => e
    ap e.message
    ap e.backtrace
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
  rescue => e
    ap e.message
    ap e.backtrace
    @result = { status: :error, reason: 'Unable to  build system setup' }
  end
end
