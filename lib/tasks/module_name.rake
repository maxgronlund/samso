namespace :module_name do
  # usage
  # rake module_name:build_defaults
  desc 'build default module class names'
  task build_defaults: :environment do
    module_names = [
      { name: 'Admin::TextModule' },
      { name: 'Admin::BlogModule' },
      { name: 'Admin::CarouselModule' },
      { name: 'Admin::DmiModule' },
      { name: 'Admin::GalleryModule' },
      { name: 'Admin::ImageModule' },
      { name: 'Admin::SubscriptionModule' },
      { name: 'Admin::PostModule' }
    ]
    module_names.each do |module_name|
      Admin::ModuleName
        .where(module_name)
        .first_or_create(module_name)
    end
  end
end
