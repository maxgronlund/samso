#######################################################
Feature: The visibility of modules

  Background:
    Given the site is ready
    And there is a "internet" subscription type
    And there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there is a "valid-subscriber" with the email "valid-subscriber@example.com" and the password "ComeOnIn123"
    And the user "valid-subscriber@example.com" has a "valid-subscription"
    And there is a "expired-subscriberer " with the email "expired-subscriber@example.com" and the password "ComeOnIn123"
    And the user "expired-subscriber@example.com" has a "expired-subscription"
    And there is a page where a text_module is visible to "all"
    And there is a page where a text_module is visible to "guests_only"
    And there is a page where a text_module is visible to "members_only"
    And there is a page where a text_module is visible to "subscribers_only"
    And there is a page where a text_module is visible to "expired_subscribers"

  Scenario: As a guest I can visit the page with a module accessible to all and see it
    When I visit the page named "all"
    Then I can see "all"

  Scenario: As a guest I can visit the page with a module accessible to guest only and see it
    When I visit the page named "guests_only"
    Then I can see "guests_only"

  Scenario:  As a guest I can visit the page with a module accessible to members only without seeing it
    When I visit the page named "members_only"
    Then I can not see "members_only"

  Scenario: As a guest I can visit the page with a module accessible to subscribers only without seeing it
    When I visit the page named "subscribers_only"
    Then I can not see "subscribers_only"

  Scenario: As a guest I can visit the page with a module accessible to expired subscribers only without seeing it
    When I visit the page named "expired_subscribers"
    Then I can not see "expired_subscribers"

  Scenario: As a member I can visit the page with a module accessible to all and see it
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the page named "all"
    Then I can see "all"

  Scenario: As a member I can visit the page with a module accessible to guest only without seeing it
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the page named "guests_only"
    Then I can not see "guests_only"

  Scenario: As a member I can visit the page with a module accessible to members only and see it
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the page named "members_only"
    Then I can see "members_only"

  Scenario: As a member I can visit the page with a module accessible to subscribers only without seeing it
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the page named "subscribers_only"
    Then I can not see "subscribers_only"

  Scenario: As a member I can visit the page with a module accessible to expired subscribers only without seeing it
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I visit the page named "expired_subscribers"
    Then I can not see "expired_subscribers"

  Scenario: As a valid subscriber I can visit the page with a module accessible to all and see it
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "all"
    Then I can see "all"

  Scenario: As a valid subscriber I can visit the page with a module accessible to guest only without seeing it
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "guests_only"
    Then I can not see "guests_only"

  Scenario: As a valid subscriber I can visit the page with a module accessible to members only and see it
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "members_only"
    Then I can see "members_only"

  Scenario: As a valid subscriber I can visit the page with a module accessible to subscribers only and see it
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "subscribers_only"
    Then I can see "subscribers_only"

  Scenario: As a valid subscriber I can visit the page with a module accessible to expired subscribers only without seeing it
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "expired_subscribers"
    Then I can not see "expired_subscribers"

  Scenario: As a expired subscriber I can visit the page with a module accessible to all and see it
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "all"
    Then I can see "all"

  Scenario: As a expired subscriber I can visit the page with a module accessible to guest only without seeing it
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "guests_only"
    Then I can not see "guests_only"

  Scenario: As a expired subscriber I can visit the page with a module accessible to members only and see it
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "members_only"
    Then I can see "members_only"

  Scenario: As a expired subscriber I can visit the page with a module accessible to subscribers only without seeing it
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "subscribers_only"
    Then I can not see "subscribers_only"

  Scenario: As a expired subscriber I can visit the page with a module accessible to expired subscribers only and see it
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit the page named "expired_subscribers"
    Then I can see "expired_subscribers"
