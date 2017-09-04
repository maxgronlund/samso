class String
  def samso_import_to_datetime
    return if self.empty?
    date_time = self.split(' ')
    date = date_time[0].split('/')
    time = date_time[1].split(':')
    Time.new date[2], date[1], date[0], time[0], time[1], time[2], '+00:00'
  end
end