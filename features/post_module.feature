#######################################################
Feature: The visibility of a blog post

  Background:
    Given the site is ready
    And there is blog page with a free and protected blog post

  Scenario: As a guest I visit the blog page and click on a post with free content
    When I visit the blog page and click on the "free_content" blog post
    Then I can see "free_content"

  Scenario: As a guest I visit the blog page and click on a post with protected content
   When I visit the blog page and click on the "protected_content" blog post
   Then I can not see "protected_content"
