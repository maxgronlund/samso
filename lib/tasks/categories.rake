namespace :categories do
  # usage
  # rake categories:build_pages
  desc 'build a page for each category'
  task build_pages: :environment do
    Admin::BlogPostCategory.find_each do |category|
      post_page = find_or_create_post_page(category)
      find_or_create_blog_page(post_page, category)
    end
  end

  def find_or_create_post_page(category)
    options = {
      title: "#{category.name}-post",
      active: category.active,
      locale: category.locale,
      menu_title: "#{category.name}-post",
      menu_id: 'not_in_any_menus'
    }
    page_col = initialize_page(options)
    find_or_create_post_module(page_col, category)
    page_col.page_row.page
  end

  def find_or_create_blog_page(post_page, category)
    options = {
      title: category.name,
      active: category.active,
      locale: category.locale,
      menu_title: category.name,
      menu_id: 'not_in_any_menus'
    }
    page_col = initialize_page(options)
    find_or_create_blog_module(page_col, post_page, category)
  end

  def initialize_page(options)
    page =
      Page
      .where(options)
      .first_or_create(options)
    page_row =
      find_or_create_page_row(page)
    page_row.page_cols.find_by(layout: 'col-sm-8')
  end

  def find_or_create_page_row(page)
    page_row =
      page
      .page_rows
      .where(layout: 'row')
      .first_or_create(layout: 'row')
    PageRow::Service.new(page_row).create_page_cols('col-8-4') if page_row.page_cols.empty?
    page_row
  end

  def find_or_create_post_module(page_col, category)
    return if page_col.page_col_modules.any?
    post_module =
      Admin::PostModule
      .where(name: category.name)
      .first_or_create(name: category.name)

    options = {
      page_col_id: page_col.id,
      moduleable_type: post_module.class.name,
      moduleable_id: post_module.id,
      position: 0,
      access_to: 'all'
    }
    PageColModule
      .where(options)
      .first_or_create(options)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def find_or_create_blog_module(page_col, post_page, category)
    blog =
      Admin::Blog
      .where(title: category.name)
      .first_or_create(
        title: category.name,
        category_id: category.id,
        locale: category.locale
      )

    options = {
      name: category.name,
      admin_blog_id: blog.id,
      posts_pr_page: 16,
      locale: blog.locale,
      post_page_id: post_page.id
    }

    blog_module =
      Admin::BlogModule
      .where(options)
      .first_or_create(options)

    options = {
      page_col_id: page_col.id,
      moduleable_type: blog_module.class.name,
      moduleable_id: blog_module.id,
      position: 0,
      access_to: 'all'
    }

    PageColModule
      .where(options)
      .first_or_create(options)
    blog_module
  end
end
