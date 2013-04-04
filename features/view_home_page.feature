=begin
  Alright.  An off-the-hip overview:
  1) Show a home page locally with a posts placeholder
  2) Format basic page divisions on home page
  3) Load a single post in entirety on the home page
  4) Add create post page, save to file
  5) Show created post on home page (reverse chron.)
  6) Replace post file with dev. db with post table
  
=end
Feature: View Home Page
  Scenario:  Successfully browse to home page
    Given web browser is launched
    When I browse to home page URL
    Then the output should be the home page
    
