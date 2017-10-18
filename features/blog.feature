Feature: The visibility of the blog depends on my status and the blogs accessibility

  Background:
    Given the site is ready
    And there is a "internet" subscription type
    And there there is a "member" with the email "member@example.com" and the password "ComeOnIn123"
    And there there is a "valid-subscriber" with the email "valid-subscriber@example.com" and the password "ComeOnIn123"
    And there there is a "expired-subscriber" with the email "expired-subscriber@example.com" and the password "ComeOnIn123"
    And there is a page where the blog is given access to "all"
    And there is a page where the blog is given access to "guests_only"
    And there is a page where the blog is given access to "members_only"
    And there is a page where the blog is given access to "subscribers_only"
    And there is a page where the blog is given access to "expired_subscribers"


  Scenario: As a guest I can visit the page with a blog accessible to all and see the blog
    When I visit the blog_page page with access to 'all'
    Then I can see the blog

  Scenario: As a member I can visit the page with a blog accessible to all and see the blog
    When I visit the blog_page page with access to 'all'
    Then I can see the blog

  Scenario: As a valid subscriber I can visit the page with a blog accessible to all and see the blog
    When I visit the blog_page page with access to 'all'
    Then I can see the blog

  Scenario: As a expired-subscriber I can visit the page with a blog accessible to all and see the blog
    When I visit the blog_page page with access to 'all'
    Then I can see the blog

  Scenario: As a guest I can visit the page with a blog accessible to guests_only and see the blog
    When I visit the blog_page page with access to 'guests_only'
    Then I can see the blog

  Scenario: As a member I can visit the page with a blog accessible to guests_only without seeing the blog
    When I login as "member@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'guests_only'
    Then I can not see the blog

  Scenario: As a valid subscriber I can visit the page with a blog accessible to guests_only without seeing the blog
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'guests_only'
    Then I can not see the blog

  Scenario: As a expired-subscriber I can visit the page with a blog accessible to guests_only without seeing the blog
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'guests_only'
    Then I can not see the blog

  Scenario: As a guest I can visit the page with a blog accessible to members_only without seeing the blog
    When I visit the blog_page page with access to 'members_only'
    Then I can not see the blog

  Scenario: As a member I can visit the page with a blog accessible to members_only and see the blog
    When I login as "member@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'members_only'
    Then I can see the blog

  Scenario: As a valid subscriber I can visit the page with a blog accessible to members_only and see the blog
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'members_only'
    Then I can see the blog

  Scenario: As a expired-subscriber I can visit the page with a blog accessible to members_only and see the blog
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'members_only'
    Then I can see the blog

  Scenario: As a guest I can visit the page with a blog accessible to subscribers_only without seeing the blog
    When I visit the blog_page page with access to 'subscribers_only'
    Then I can not see the blog

  Scenario: As a member I can visit the page with a blog accessible to subscribers_only without seeing the blog
    When I login as "member@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'subscribers_only'
    Then I can not see the blog

  Scenario: As a valid subscriber I can visit the page with a blog accessible to subscribers_only and see the blog
    When I login as "valid-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'subscribers_only'
    Then I can see the blog

  Scenario: As a expired-subscriber I can visit the page with a blog accessible to subscribers_only without seeing the blog
    When I login as "expired-subscriber@example.com" with the password "ComeOnIn123"
    And I visit the blog_page page with access to 'subscribers_only'
    Then I can not see the blog






