namespace :pages do
  # usage
  # rake pages:build
  desc 'build a page for each blog'
  task build: :environment do
    Admin::Blog.find_each do |blog|
      find_or_create_post_page(blog)
      find_or_create_category_page(blog)
    end
  end

  def find_or_create_category_page(blog)
    options = {
      title: "Kategori-#{blog.title}",
      active: true,
      locale: blog.locale,
      menu_title: "Kategori #{blog.title}",
      menu_id: 'not_in_any_menus',
      category_page: true
    }
    page_col = find_or_create_page(options)
    find_or_create_blog_module(page_col, blog)
  end

  def find_or_create_post_page(blog)
    options = {
      title: blog.title,
      active: true,
      locale: blog.locale,
      menu_title: blog.title,
      menu_id: 'not_in_any_menus',
      category_page: false
    }
    page_col = find_or_create_page(options)
    find_or_create_post_module(page_col, blog)
  end

  def find_or_create_page(options)
    page =
      Page
      .where(options)
      .first_or_create(options)
    page_row = find_or_create_page_row(page)
    page_row.page_cols.find_by(layout: 'col-md-8')
  end

  def find_or_create_page_row(page)
    page_row =
      page
      .page_rows
      .where(layout: 'row', padding_top: 20)
      .first_or_create(layout: 'row', padding_top: 20)
    PageRow::Service.new(page_row).create_page_cols('col-8-4') if page_row.page_cols.empty?
    page_row
  end

  def find_or_create_post_module(page_col, blog)
    return if page_col.page_col_modules.any?

    post_module =
      Admin::PostModule
      .where(name: blog.title)
      .first_or_create(name: blog.title)

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

  def find_or_create_blog_module(page_col, blog)
    options = blog_module_options(blog)
    blog_module =
      Admin::BlogModule
      .where(options)
      .first_or_create(options)

    find_or_create_page_col_module(page_col, blog_module)
  end

  def find_or_create_page_col_module(page_col, blog_module)
    options = page_col_module_options(page_col, blog_module)
    PageColModule
      .where(options)
      .first_or_create(options)
    blog_module
  end

  def blog_module_options(blog)
    {
      name: blog.title,
      admin_blog_id: blog.id,
      posts_pr_page: 16,
      locale: blog.locale
    }
  end

  def page_col_module_options(page_col, blog_module)
    {
      page_col_id: page_col.id,
      moduleable_type: blog_module.class.name,
      moduleable_id: blog_module.id,
      position: 0,
      access_to: 'all'
    }
  end
end
