# crewgen.rb

require 'sinatra/base'
require 'ftl_tools'

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

    def build_crew
      builder             = FTLTools::CharacterBuilder.new
      @crew               = Hash.new
      @crew['pilot']      = builder.setup
      builder.reset 
      @crew['navigator']  = builder.setup
      builder.reset 
      @crew['engineers']  = Array.new
      2.times {
        @crew['engineers'] << builder.setup
        builder.reset 
      }
      
    end

    def build_ship(params)
      @params         = params
      @ship       = Hash.new
      @ship['name']   = @params[:ship_name]
    end
 
    get('/crew') do
      build_crew
      erb :crew
    end

    get('/build') do
      erb :build
    end

    post('/show_ship') do
      build_ship(params)
      "Ship name is #{@ship['name']}"
    end

  end

end
