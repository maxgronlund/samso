Feature: As a guest I can login

  Background:
    Given the site is ready
    And there there is a user with the email "joesph-r-evans@teleworm.us" and the password "ComeOnIn123"

  Scenario: I can visit the landing page and see the login link
    When I visit the "landing_page" page
    Then I can see a "login" link

  Scenario: As a guest I can visit the landing page and click on the login link
    When I visit the "landing_page" page
    Then I can click on a "login" link
    Then I can see the login page

  Scenario: As a guest I can fill in the login form with a valid email and password
    When I visit the "login_page" page
    Then I submit the login form with the email "joesph-r-evans@teleworm.us" and the password "ComeOnIn123"
    Then I can see the "sign_out" link

