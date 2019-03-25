namespace :subscription_types do

  # usage
  # rake subscription_types:build_defaults
  desc 'build default subscription types for e-conomic imports'
  task build_defaults: :environment do
    Admin::SubscriptionType
      .where(identifier: Admin::SubscriptionType::FROM_ECONOMICS)
      .first_or_create(
        title: "Import af 'Abonnement' gruppen fra economic",
        body: 'Må ikke slettes',
        identifier: Admin::SubscriptionType::FROM_ECONOMICS,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: false
      )
    Admin::SubscriptionType
      .where(identifier: Admin::SubscriptionType::FREE_FROM_ECONOMICS)
      .first_or_create(
        title: "Import af 'FriAbb' gruppen fra economic",
        body: 'Må ikke slettes',
        identifier: Admin::SubscriptionType::FREE_FROM_ECONOMICS,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: true
      )
    Admin::SubscriptionType
      .where(identifier: Admin::SubscriptionType::AB_EAN_FROM_ECONOMICS)
      .first_or_create(
        title: "Import af 'AB-EAN' gruppen fra economic",
        body: 'Må ikke slettes',
        identifier: Admin::SubscriptionType::AB_EAN_FROM_ECONOMICS,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: false
      )
    Admin::SubscriptionType
      .where(identifier: Admin::SubscriptionType::FREE)
      .first_or_create(
        title: "Fri Abonnement",
        body: 'Må ikke slettes',
        identifier: Admin::SubscriptionType::FREE,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: false
      )
    Admin::SubscriptionType
      .where(identifier: Admin::SubscriptionType::DAO_IMPORTED)
      .first_or_create(
        title: "Import fra DAO Liste",
        body: 'Må ikke slettes',
        identifier: Admin::SubscriptionType::DAO_IMPORTED,
        duration: 365000,
        internet_version: true,
        print_version: true,
        price: 0,
        locale: 'da',
        active: false,
        position: 0,
        free: false
      )
  end
end
