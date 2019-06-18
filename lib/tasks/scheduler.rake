desc 'This task is called by the Heroku scheduler add-on'
task send_reminders: :environment do
  # Admin::Subscription::Service.send_reminders
  # Admin::Newsletter::Service.send_newsletters
  WeeklyComment.destroy_old_weekly_comments!
  BlogPostStat.destroy_old_weekly_views!
end
