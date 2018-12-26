FactoryBot.define do
  sequence :blog_post_title do |n|
    "#{Faker::TvShows::HeyArnold.quote}_#{n}"
  end

  sequence :blog_post_subtitle do |n|
    "#{Faker::Hipster.sentence}_#{n}"
  end

  sequence :blog_post_teaser do |n|
    "#{Faker::TvShows::HowIMetYourMother.quote}_#{n}"
  end

  sequence :blog_post_body do |n|
    "#{Faker::Hipster.paragraph}_#{n}"
  end

  sequence :blog_post_signature do |n|
    "#{Faker::Name.name}_#{n}"
  end

  sequence :blog_title do |n|
    "#{Faker::Name.name}_#{n}"
  end
end
