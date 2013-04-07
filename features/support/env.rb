require 'capybara/cucumber'
#require File.join(File.dirname(__File__), '..', '..', 'blog_app')
require './blog_app'

Capybara.app = BlogApp
