FactoryBot.define do
  factory :payment, class: Payment do |f|
    f.uuid {SecureRandom.uuid}
    f.state {'pending'}
    f.transaction_info {'na'}
    f.payment_provider {'onpay'}
    f.onpay_reference {'1234'}  end
end
