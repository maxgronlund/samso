Feature: As a guest or a member I can only see protected content when I have a valid subscription

  Background:
    Given the site is ready
    And there is a "Internet" subscription type
    And there there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there there is a "expired-subscriber" with the email "expired-subscriber@example.com" and the password "ComeOnIn123"
    And there there is a "valid-subscriber" with the email "valid-subscriber@example.com" and the password "ComeOnIn123"
    And there is a page named "members-only" with a text module with the title "Breaking news" and a subscription module

  Scenario: As a guest I visit members-only page and can not see text module
    When I visit the page named "members-only"
    Then I can see "Subscribe to this funky content"

  Scenario: As a member without any subscriptions I visit a members-only page
    When I login as "member@example.com" with the password "ComeOnIn123"
    And I visit the page named "members-only"
    Then I can see "Subscribe to this funky content"

  Scenario: As a member with an expired subscriptions I visit a members-only page
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the page named "members-only"
    Then I can see "Subscribe to this funky content"

  Scenario: As a member with a valid subscriptions I visit a members-only page
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the page named "members-only"
    Then I can see "Breaking news"




