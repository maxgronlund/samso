#######################################################
Feature: Create Update and Delete blog posts

  Background:
    Given the site is ready
    And there is a "editor" with the email "editor@example.com" and the password "ComeOnIn123"
    And there is a blog page with 10 blog posts

  @javascript
  Scenario: As a editor I can create a new blog post
    When I login as "editor@example.com" with the password "ComeOnIn123"
    Then I visit the articles page
    Then I can click "blog_post.new"
    Then I fill the form and submit it
    Then I can see the post I created
