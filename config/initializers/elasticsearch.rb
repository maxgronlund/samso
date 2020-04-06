if Rails.env.production?
  Searchkick.client =
    Elasticsearch::Client.new(
      hosts: ["https://paas:a8a01d233d3291abe7f0721b9f909663@gloin-eu-west-1.searchly.com"],
      retry_on_failure: true,
      transport_options: {request: {timeout: 250}}
    )
end