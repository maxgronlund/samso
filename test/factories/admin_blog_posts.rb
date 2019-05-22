FactoryBot.define do
  factory :admin_blog_post, class: 'Admin::BlogPost' do
    layout { 'image_right' }
    title { generate(:blog_post_title) }
    subtitle { generate(:blog_post_subtitle) }
    teaser { generate(:blog_post_teaser) }
    body { generate(:blog_post_body) }
    position { 1 }
    blog_id { 1 }
    free_content { false }
    featured { false }
    start_date { '2018-12-22 08:16:05' }
    end_date { '2018-12-22 08:16:05' }
    user_id { 1 }
    obsolete_views { 1 }
    signature { generate(:blog_post_signature) }
    post_page_id { 1 }
    created_at { '2018-12-22 08:16:05' }
    updated_at { '2018-12-22 08:16:05' }
    video_url { 'MyText' }
    enable_comments { false }
    show_facebook_comments { false }
  end
end
