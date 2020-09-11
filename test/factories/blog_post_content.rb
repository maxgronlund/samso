include ActionDispatch::TestProcess

FactoryBot.define do
  factory :blog_post_content, class: Admin::BlogPostContent do |f|
    f.body { 'I also became close to nature, and am now able to appreciate the beauty with which this world is endowed.' }
    f.position { 1 }
    f.blog_post_id { 1 }
    f.image { fixture_file_upload("#{Rails.root}/test/fixtures/files/flag.png", 'image/png') }
    f.layout { 'image_top' }
  end
end
