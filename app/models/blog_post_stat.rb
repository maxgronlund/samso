class BlogPostStat < ApplicationRecord
  belongs_to :admin_blog_post, class_name: 'Admin::BlogPost'


  def shown!
    update_attributes(views: views + 1) unless updated_at > DateTime.now - 0.5.seconds
  rescue => e
    metadate =
      { blog_post_id: id, title: title }
      .merge(
        message: e.message,
        backtrace: e.backtrace
      )

    Admin::EventNotification.create(
      title: 'ERROR! BlogPostStat',
      body: 'Unable to update views',
      message_type: 'blot_post_stat',
      metadata: metadate
    )
  end
end
