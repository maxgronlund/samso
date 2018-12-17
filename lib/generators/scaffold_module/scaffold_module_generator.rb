# scaffold a new module
class ScaffoldModuleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  # def create_views_directory
  #   empty_directory "app/views/admin/#{file_name}"
  # end

  def generate_views
    template 'views/admin/_show.erb', "app/views/admin/#{file_name}_modules/_show.slim"
    template 'views/admin/edit.erb', "app/views/admin/#{file_name}_modules/edit.slim"
    template 'views/_show.erb', "app/views/#{file_name}_modules/_show.slim"
    # template 'views/_section_html_slim.erb', "app/views/admin/sections/_#{file_name}.html.slim"
    # template 'views/_form_html_slim.erb', "app/views/admin/#{file_name.pluralize}/_form.html.slim"
    # template 'views/edit_html_slim.erb', "app/views/admin/#{file_name.pluralize}/edit.html.slim"
  end

  def generate_controller
    template 'controllers/admin/controller.erb', "app/controllers/admin/#{file_name}_modules_controller.rb"
  end

  def generate_model
    template 'models/admin/model.erb', "app/models/admin/#{file_name}_module.rb"
  end

  def add_assets
    # copy_file 'section.js.coffee', "app/assets/javascripts/#{file_name.pluralize}.js.coffee"
    # copy_file 'section.css.scss', "app/assets/stylesheets/#{file_name.pluralize}.css.scss"
  end

  def add_locale
    template 'config/locales/locale.erb', "config/locales/#{file_name}_module.en.yml"
    # copy_file 'section.css.scss', "app/assets/stylesheets/#{file_name.pluralize}.css.scss"
  end

  def generate_migration
    template 'migrate/migration.erb', "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_create_admin_#{file_name}_modules.rb"
  end
end
