Feature: As a guest I can signup

  Background:
    Given the site is ready

  Scenario: As a guest I can visit the login page and see the signup link
    When I visit the "login_page" page
    Then I can see a "signup" link

  Scenario: As a guest I can visit the login page and click on the signup link
    When I visit the "login_page" page
    Then I can click on a "signup" link
    Then I can see the signup page

  Scenario: As a guest I can signup
    When I visit the "signup_page" page
    And I submit the signup form with "Mary L. Phillips", "mary-l-phillips@teleworm.us", "ComeOnIn123"
    Then I can see the thanks for signing up screen

  Scenario: As user can confirm an account
    When an unconfirmed user has signed up
    Then the user can confirm the account



