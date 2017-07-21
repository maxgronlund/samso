namespace :page do
  # usage
  # rake page:build_subscription_pages
  desc 'build default subscriptions pages'
  task build_subscription_pages: :environment do
    user = User.super_admin
    pages_params = [
      { title: 'Abonnere', menu_title: 'Abonnere', menu_id: 'None', locale: 'da', layout: 'alabama', active: true, user_id: user.id },
      { title: 'Subscribe', menu_title: 'Subscribe', menu_id: 'None', locale: 'en', layout: 'alabama', active: true, user_id: user.id }
    ]

    pages_params.each do |page_params|
      page = Page.where(page_params).first_or_create(page_params)
      Admin::SystemSetup.current.update_attributes(
        "#{page_params[:locale]}_subscription_page_id".to_sym => page.id
      )
    end
  end

  # usage
  # rake page:build_front_pages
  desc 'build default front pages'
  task build_front_pages: :environment do
    user = User.super_admin
    pages_params = [
      { title: 'Forside', menu_title: 'SAMSØ', menu_id: 'Ingen', locale: 'da', layout: 'alabama', active: true, user_id: user.id },
      { title: 'Front page', menu_title: 'SAMSØ', menu_id: 'None', locale: 'en', layout: 'alabama', active: true, user_id: user.id }
    ]

    pages_params.each do |page_params|
      page = Page.where(page_params).first_or_create(page_params)
      Admin::SystemSetup.current.update_attributes(
        "#{page_params[:locale]}_landing_page_id".to_sym => page.id
      )
    end
  end

  # usage
  # rake page:build_post_pages
  desc 'build post pages'
  task build_post_pages: :environment do
    user = User.super_admin
    pages_params = [
      { title: 'Artikel', menu_title: 'Artikel', menu_id: 'Ingen', locale: 'da', layout: 'alabama', active: true, user_id: user.id },
      { title: 'Article', menu_title: 'Article', menu_id: 'None', locale: 'en', layout: 'alabama', active: true, user_id: user.id }
    ]

    pages_params.each do |page_params|
      page = Page.where(page_params).first_or_create(page_params)
      Admin::SystemSetup.current.update_attributes(
        "#{page_params[:locale]}_post_page_id".to_sym => page.id
      )
    end
  end
end
