#######################################################
Feature: I can login and get access based on my role

  Background:
    Given the site is ready
    And there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there is a "editor" with the email "editor@example.com" and the password "ComeOnIn123"
    And there is a "admin" with the email "admin@example.com" and the password "ComeOnIn123"

  Scenario: I can visit the landing page and see the login link
    When I visit the "landing_page" page
    Then I can see a "login" link
    Then I can not see a "admin" link

  Scenario: As a guest I can visit the landing page and click on the login link
    When I visit the "landing_page" page
    Then I can click on a "login" link
    Then I can see the login page

  Scenario: As a guest I can fill in the login form with a valid email and password
    When I visit the "login_page" page
    When I login as "member@example.com" with the password "ComeOnIn123"
    Then I can see the "sign_out" link
    Then I can not see a "admin" link

