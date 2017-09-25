namespace :module_name do
  # usage
  # rake module_name:build_defaults
  desc 'build default module class names'
  task build_defaults: :environment do
    module_names = [
      { name: 'Admin::SubscriptionModule', locale: 'admin/subscription_module.name', position: 0 },
      { name: 'Admin::BlogModule', locale: 'admin/blog_module.name', position: 1 },
      { name: 'Admin::BlogPost', locale: 'admin/blog_post.name', position: 2 },
      { name: 'Admin::DmiModule', locale: 'admin/dmi_module.name', position: 3 },
      { name: 'Admin::CarouselModule', locale: 'admin/carousel_module.name', position: 4 },
      { name: 'Admin::GalleryModule', locale: 'admin/gallery_module.name', position: 5 },
      { name: 'Admin::ImageModule', locale: 'admin/image_module.name', position: 6 },
      { name: 'Admin::TextModule', locale: 'admin/text_module.name', position: 7 }
    ]
    module_names.each do |module_name|
      Admin::ModuleName
        .where(module_name)
        .first_or_create(module_name)
    end
  end
end
