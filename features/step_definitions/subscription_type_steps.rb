Given('there is a {string} subscription type') do |subscription_type|
  case subscription_type
  when 'internet'
    internet_subscription_type('Online access')
  when 'print'
    print_subscription_type('Printed version and online access')
  end
end
