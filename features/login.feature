Feature: As a guest I can login
  Scenario: As a guest I can visit the landing page and se a login link
    Given the site is ready
    And the guest is on the front page
    Then a guest can see a link "Login"
