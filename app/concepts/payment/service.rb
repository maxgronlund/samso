class Payment::Service
  require 'openssl'
  require 'uri'

  def self.mac_sha1(params = {}, secret)
    data = on_pay_data(params)
    encrypt(data, secret)
  end

  # Remove all keys not starting with 'onpay_'
  # Sort alphabetic and convert to hash
  def self.on_pay_data(params)
    params = params.select { |key, _| key.to_s.include?('onpay_') }
    params.sort.to_h
  end

  # Url encode and encode with secret
  def self.encrypt(data, secret)
    uri_encoded_data =
      URI
      .encode_www_form(data)
      .downcase

    OpenSSL::HMAC
      .hexdigest(
        digest,
        secret,
        uri_encoded_data
      )
  end

  def self.digest
    OpenSSL::Digest.new('sha1')
  end
end

# $ test_data = {
#   onpay_gatewayid: '20007895654',
#   onpay_currency: 'DKK',
#   onpay_amount: '12000',
#   onpay_reference: 'AF-847824',
#   onpay_accepturl: 'https://example.com/accept',
#   unrelated_param: 'bla bla bla'
# }
# $ secret = "e88ebc73104651e3c8ee9af666c19b0626c9ecacd7f8f857e3633e355776baad92e67b7faf9b87744f8c6ce4303978ed65b4165f29534118c882c0fd95f52d0c"
# $ Payment::Service.mac_sha1(test_data, secret)
# => "16586ad0b3446b58df92446296cf821500ac57d8"

