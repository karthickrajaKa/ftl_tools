# crewgen.rb

require 'sinatra/base'

module FTLTools

  # Provides the web interface for the crewgen app.  
  class CrewGen < Sinatra::Base

    def initialize
      super()
    end

    configure do
      working_dir     = File.dirname(__FILE__).split('/')
      working_dir.pop
      working_dir[-1] = 'views'
      views_dir       = working_dir.join('/')
      set :views, views_dir 
    end

    get('/crew') do
      erb :crew
    end
  end

end
