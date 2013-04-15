require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "blog_app"))

require "capybara"
require "capybara/cucumber"
 
World do
  Capybara.app = Boiblog::BlogApp 
end

