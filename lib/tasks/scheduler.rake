desc 'This task is called by the Heroku scheduler add-on'
task send_reminders: :environment do
  Admin::Subscription::Service.send_reminders
end

task send_newsletters: :environment do
  Admin::Newsletter::Service.send_newsletters
end

task destroy_old_weekly_comments: :environment do
  WeeklyComment.destroy_old_weekly_comments!
end

task destroy_old_weekly_views: :environment do
  BlogPostStat.destroy_old_weekly_views!
end
