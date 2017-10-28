# Helper for creating pages
module KnowPageHelper
  def create_page_with_module(options = {})
    page            = create_page(options)
    page_col        = setup_page_col(page)
    moduleable      = options[:moduleable]
    create_page_col_module(page_col, moduleable, options)
    page
  end

  def create_page(options = {})
    title = options[:title] || Faker::Name.name
    menu_title = options[:menu_title] || Faker::Name.name
    menu_id = options[:menu_id] || 'not_in_any_menus'
    FactoryGirl
      .create(
        :page,
        title: title,
        menu_title: menu_title,
        menu_id: menu_id,
        locale: I18n.locale
      )
  end

  def setup_page_col(page)
    page_row = page.page_rows.create(layout: 'row')
    page_row_service = PageRow::Service.new(page_row)
    page_row_service.create_page_cols('8-4')
    page_row.page_cols.first
  end

  def create_page_col_module(page_col, moduleable, options = {})
    access_to = options[:access_to] || 'all'
    page_col
      .page_col_modules
      .create(
        moduleable_type: moduleable.class.name,
        moduleable_id: moduleable.id,
        access_to: access_to
      )
  end

  def add_module_to_page(options = {})
    moduleable = options[:moduleable]
    page = options[:page]
    page_row = page.page_rows.first
    page_col = page_row.page_cols.first
    create_page_col_module(page_col, moduleable, options)
  end
end

World(KnowPageHelper)
