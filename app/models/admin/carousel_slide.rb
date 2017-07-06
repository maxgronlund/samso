class Admin::CarouselSlide < ApplicationRecord
  belongs_to :carousel_module, class_name: 'Admin::CarouselModule'
end
