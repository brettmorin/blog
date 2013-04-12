require 'sinatra/base'
require 'sinatra/reloader'

module Boiblog
  class BlogApp < Sinatra::Base
    register Sinatra::Reloader
    
    get '/' do
      erb :home
    end
    
    post '/' do
      "You said '#{params[:message]}'."
    end
  end
end

if __FILE__ == $0
  Boiblog::BlogApp.run! port: 9292
end
