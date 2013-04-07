#  Alright.  An off-the-hip overview:
#  1) Show a home page locally with a posts placeholder
#  2) Format basic page divisions on home page
#  3) Load a single post in entirety on the home page
#  4) Add create post page, save to file
#  5) Show created post on home page (reverse chron.)
#  6) Replace post file with dev. db with post table


Feature: View Home Page
  Scenario:  Home page should say "Blog Home"
    When I visit the home page
    Then I should see "Blog Home"
    
