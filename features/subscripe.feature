Feature: As a guest or a member I can superscribe to payed for content content

  Background:
    Given the site is ready
    And there is a "internet" subscription type
    And there there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there there is a "expired-subscriber" with the email "expired-subscriber@example.com" and the password "ComeOnIn123"
    And there is a page with a "subscription_module" where access_to is set to "all_without_valid_subscription"

  Scenario: As a guest I visit a blog post page
    When I visit the "blog_post" page
    Then I can see the subscription module

  Scenario: As a member without any subscriptions I visit a blog post page
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the "blog_post" page
    Then I can see the subscription module

  Scenario: As a member with an expired subscriptions I visit a blog post page
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    When I visit the "blog_post" page
    Then I can see the subscription module




