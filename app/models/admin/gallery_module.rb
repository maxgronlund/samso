# frozen_string_literal: true

# Gallery module
class Admin::GalleryModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns
  has_many :images, class_name: 'Admin::GalleryImage', dependent: :destroy, foreign_key: 'gallery_module_id'
  belongs_to :page, optional: true

  def latest_images
    images.order('created_at DESC')
  end

  def paginated_images(page_id)
    page_id = 0 if page_id.nil?
    latest_images.limit(images_pr_page).offset(page_id.to_i * images_pr_page)
  end

  def show_page
    Page.find_by(id: page_id)
  end

  def prev_page(request_path, current_page)
    page = current_page.to_i - 1
    return request_path if page <= 0

    "#{request_path}?page=#{page}"
  end

  def next_page(request_path, current_page)
    page = current_page.to_i + 1
    return false if page * images_pr_page >= gallery_images_count

    "#{request_path}?page=#{page}"
  end

  def style
    "background-color: #{background_color};min-height: 451px;"
  end
end
