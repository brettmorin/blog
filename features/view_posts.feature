Feature: View Posts
  Scenario:  Successfully View All Blog Posts
    Given blog contains posts titled "Post 1" and "Post 2"
    When I view all posts
    Then the output should be "Post 2. \n Post 1." 
