require 'net/http'

class Admin::SignInIp < ApplicationRecord
  belongs_to :user, counter_cache: true

  def location
    # curl -u 9bd1d2726a3a47 ipinfo.io/152.115.55.39
    url = URI.parse("http://ipinfo.io/#{ip.to_s}?token=9bd1d2726a3a47")
    req = Net::HTTP::Get.new(url.to_s)

    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    JSON.parse(res.body)
  end
end





