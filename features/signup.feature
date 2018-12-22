#######################################################
Feature: Gests can signup

  Background:
    Given the site is ready

  Scenario: As a guest I can visit the login page and see the signup link
    When I visit the "login_page" page
    Then I can see a "signup" link

  Scenario: As a guest I click on the signup link
    When I visit the "landing_page" page
    Then I can click on a "signup" link
    Then I can see the signup page

  Scenario: As a guest I can signup
    When I visit the "signup_page" page
    And I submit the signup form with "Mary L. Phillips", "mary-l-phillips@teleworm.us", "ComeOnIn123"
    Then I can see the thanks for signing up screen

  Scenario: As user can confirm an account
    When I signup with the email "unconfirmed@example.com" and the password "ComeOnIn123"
    Then the user with the email "unconfirmed@example.com" can confirm the account



