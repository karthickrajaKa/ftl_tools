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
      @ship.engineer_count.times {
        @crew['engineers'] << builder.setup
        builder.reset 
      }
      
    end

    def build_ship(params)
      #@params       = params
      p params
      ship_data = Hash.new
      ship_data['name'] = 'Miss Rosa'
      ship_data['hull_size'] = 200
      ship_data['drive_size'] = 20

      ship_builder  = FTLTools::ShipBuilder.new
      #@ship         = ship_builder.setup(@params)
      @ship         = ship_builder.setup(ship_data)
    end
 
    post('/crew') do
      build_ship(params)
      build_crew
      erb :crew
    end

    get('/build') do
      erb :build
    end

    #post('/show_ship') do
    #  @ship = build_ship(params)
    #  redirect '/crew'
    #end

  end

end
