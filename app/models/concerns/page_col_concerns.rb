# frozen_string_literal: true

# Shared functionalith between page_col_modules
module PageColConcerns
  extend ActiveSupport::Concern
  attr_accessor :position, :margin_bottom, :access_to

  def position
    page_col_module&.position.presence || 0
  end

  def access_to
    page_col_module&.access_to.presence || 'all_without_valid_subscription'
  end

  def show
    page_col_module.show.presence
  end

  def margin_bottom
    page_col_module.margin_bottom.presence || 0
  end
  # rubocop:enable Lint/DuplicateMethods

  def page_col_module
    page_col_modules.first
  end

  def page_col
    page_col_module&.page_col.presence
  end

  def page
    page_col&.page.presence
  end

  def update_position(new_position)
    page_col_module
      .update_attributes(position: new_position)
    clear_page_cache
  end

  def update_page_col_module(params)
    return if page_col_module.nil?

    page_col_module
      .update_attributes(
        position: params[:position],
        access_to: params[:access_to]
      )
  end

  def update_margin_bottom(margin_bottom)
    page_col_module.update_attributes(margin_bottom: margin_bottom)
    clear_page_cache
  end

  # usage Admin::SystemSetup.clear_page_cache
  def clear_page_cache
    page.touch
  end
end
