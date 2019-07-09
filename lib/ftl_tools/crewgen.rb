# crewgen.rb

#$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'sinatra/base'

module FTLTools
  
  class CrewGen < Sinatra::Base

    def initialize
      super()
    end

    configure do
      working_dir     = File.dirname(__FILE__).split('/')
      working_dir[-1] = 'views'
      views_dir       = working_dir.join('/')
      set :views, views_dir 
    end

    get('/crew') do
      erb :crew
    end
  end

end
