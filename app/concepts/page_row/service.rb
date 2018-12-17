# namespace to confine service class to User::Service
class PageRow < ApplicationRecord
  # usage:
  # PageRow::Service.new(PageRow)
  class Service
    def initialize(page_row)
      @page_row = page_row
    end

    def create_page_cols(preset)
      preset.gsub!('col-', '')
      preset.split('-').each_with_index do |page_col_layout, index|
        @page_row
          .page_cols
          .create(
            layout: 'col-md-' + page_col_layout,
            index: index
          )
      end
    end

    def update_preset(layout)
      new_cols = layout.split('_')
      new_cols_count = new_cols.count
      old_cols_count = @page_row.page_cols_count

      return unless old_cols_count > new_cols_count

      move_page_cols_content(new_cols_count)
    end

    private

    def move_page_cols_content(new_cols_count)
      page_cols =
        @page_row
        .ordered_page_cols
        .where('index > ?', new_cols_count)
      move_page_col_module(page_cols, new_cols_count)
    end

    def move_page_col_module(page_cols, index)
      move_to_page_col =
        page_cols
        .find_by(index: index)
        .last

      move_modules_to_col(move_to_page_col, page_cols)
    end

    def move_modules_to_col(move_to_page_col, page_cols); end
  end
end
