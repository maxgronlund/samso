#######################################################
Feature: I can see the subscription module if I have no valid subscription

  Background:
    Given the site is ready
    And there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there is a "valid-subscriber" with the email "valid-subscriber@example.com" and the password "ComeOnIn123"
    And the user "valid-subscriber@example.com" has a "valid-subscription"
    And there is a "expired-subscriber" with the email "expired-subscriber@example.com" and the password "ComeOnIn123"
    And the user "expired-subscriber@example.com" has a "expired-subscription"
    And there is a page with a text module and a subscription module

  Scenario: As a guest I can visit members-only page and see the subscription module
    When I visit the page named "subscribers_only"
    Then I can not see "subscribers_only"
    Then I can see "Subscribe to this funky content"

  Scenario: As a valid subscriber I can visit members-only page and see the text module
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "subscribers_only"
    Then I can see "subscribers_only"
    Then I can not see "Subscribe to this funky content"

  Scenario: As a valid subscriber I can visit members-only page and see the text module
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "subscribers_only"
    Then I can not see "subscribers_only"
    Then I can see "Subscribe to this funky content"






