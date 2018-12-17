# frozen_string_literal: true

# show weather from DMI
class Admin::ReadAlsoModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::ReadAlsoModule',
      moduleable_id: id
    )
  end

  def posts
    if show_all_categories?
      Admin::BlogPost
        .all_posts
        .first(posts_pr_page)
    else
      Admin::BlogPost
        .all_posts
        .where(blog_id: blog_id)
        .first(posts_pr_page)
    end
  end
end
