require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "blog_app"))

require "capybara"
require "capybara/cucumber"
require "rspec"
 
World do
  Capybara.app = Boiblog::BlogApp 
  #include Capybara::DSL
  #include RSpec::Matchers
end

=begin
require 'childprocess'
require 'timeout'
require 'httparty'
server = ChildProcess.build("rackup", "--port", "9999")
server.start
Timeout.timeout(3) do
  loop do
    begin 
      HTTParty.get('http://localhost:9999')
      break
    rescue Errno::ECONNREFUSED => try_again
      sleep 0.1
    end
  end
end

at_exit do
  server.stop
end
=end
