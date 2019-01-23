class Payment::Service
  require 'openssl'
  require 'uri'

  def self.mac_sha1(params = {})
    data = on_pay_data(params)
    encrypt(data)
  end

  def self.on_pay_data(params)
    params = params.select { |key, _| key.to_s.include?('onpay_') }
    params.sort.to_h
  end

  def self.encrypt(data)
    uri_encoded_data =
      URI
      .encode_www_form(data)
      .downcase

    OpenSSL::HMAC
      .hexdigest(
        digest,
        ENV['ON_PAY_SECRET'],
        uri_encoded_data
      )
  end

  def self.digest
    OpenSSL::Digest.new('sha1')
  end
end

# def self.test_data
#   {
#     onpay_gatewayid: '20007895654',
#     onpay_currency: 'DKK',
#     onpay_amount: '12000',
#     onpay_reference: 'AF-847824',
#     onpay_accepturl: 'https://example.com/accept',
#     unrelated_param: 'bla bla bla'
#   }
# end
