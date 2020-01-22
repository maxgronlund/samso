#######################################################
Feature: I can see the subscription module if I have no valid subscription

  Background:
    Given the site is ready
    And there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there is a "valid-subscriber" with the email "valid-subscriber@example.com" and the password "ComeOnIn123"
    And the user "valid-subscriber@example.com" has a "valid-subscription"

  @javascript
  Scenario: As a user I can edit my profile
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    Then I visit my account page
    Then I can see my account
    Then I can click on a "edit" link
    Then I can change my address
