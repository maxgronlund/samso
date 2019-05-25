require 'net/http'

class Admin::SignInIp < ApplicationRecord
  belongs_to :user, counter_cache: true

  def location
    url = URI.parse("http://ipinfo.io/#{ip.to_s}?token=#{ENV['IPINFO_TOKEN']}")
    req = Net::HTTP::Get.new(url.to_s)

    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    JSON.parse(res.body)
  end

  def fetch_ipinfo
    update(ipinfo: location)
  end

  def ipinfo
    fetch_ipinfo if self[:ipinfo].empty?
    self[:ipinfo]
  end
end
