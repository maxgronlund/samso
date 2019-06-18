desc 'Send reminders to all subscribers about to expire'
task send_reminders: :environment do
  Admin::Subscription::Service.send_reminders
end

desc 'Send news letter'
task send_newsletters: :environment do
  Admin::Newsletter::Service.send_newsletters
end

desc 'Destroy old weekly comments'
task destroy_old_weekly_comments: :environment do
  WeeklyComment.destroy_old_weekly_comments!
end

desc 'Destroy old weekly views'
task destroy_old_weekly_views: :environment do
  BlogPostStat.destroy_old_weekly_views!
end
