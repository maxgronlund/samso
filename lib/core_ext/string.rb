# additional custom functions
class String
  # rubocop:disable Metrics/AbcSize
  def samso_import_to_datetime
    return if empty?
    date_time = split(' ')
    return if date_time[0].nil? || date_time[1].nil?
    date = date_time[0].split('/')
    time = date_time[1].split(':')
    return if date.nil? || date[2].nil? || date[1].nil? || date[0].nil?
    return if time.nil? || time[0].nil? || time[1].nil? || time[2].nil?
    Time.new date[2], date[1], date[0], time[0], time[1], time[2], '+00:00'
  end
  # rubocop:enable Metrics/AbcSize
end
