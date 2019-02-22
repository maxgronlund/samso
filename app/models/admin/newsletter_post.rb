class Admin::NewsletterPost < ApplicationRecord
  belongs_to :admin_blog_post, class_name: 'Admin::BlogPost'
  belongs_to :admin_newsletter, class_name: 'Admin::Newsletter'
end
