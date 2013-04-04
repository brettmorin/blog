Feature: Create Post

  Scenario: Successful creation of first post
    Given this post:
      |title      |Post 1                 |
      |content    |This is the first post.|
    When I submit this post
    Then output should be "Post 1 \n This is the first post."
