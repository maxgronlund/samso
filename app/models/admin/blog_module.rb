# dynamic blog to add on a page
class Admin::BlogModule < ApplicationRecord
  has_many :posts, class_name: 'Admin::BlogPost', dependent: :destroy
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def paginated_posts(start = 0, finish = 100)
    posts
      .offset(start)
      .order('start_date DESC')
      .last(finish - start)
  end

  def show_on_page
    Page.find_by(id: post_page_id)
  end
end
