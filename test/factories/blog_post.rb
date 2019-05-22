FactoryBot.define do
  factory :blog_post, class: Admin::BlogPost do |f|
    f.legacy_id { nil }
    f.title { 'I noticed your band is on the roster' }
    f.subtitle { nil }
    f.teaser { nil }
    f.body { "Calm down, Marty. I didn't disintegrate anything. The molecular structure of both Einstein and the car are completely intact." }
    f.position { nil }
    f.blog_id { 1 }
    f.free_content { false }
    f.featured { false }
    f.end_date { nil }
    f.user_id { 1 }
    f.obsolete_views { 1 }
    f.signature { 'Jack the Penn' }
    f.post_page_id { nil }
    f.image_file_name { nil }
    f.image_content_type { nil }
    f.image_file_size { nil }
    f.image_updated_at { nil }
    f.layout { 'image_left' }
    f.start_date { Time.zone.now - 1.day }
  end
end
