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
      @crew['pilot']      = builder.setup({'career' => 'Pilot'})
      builder.reset 
      @crew['navigator']  = builder.setup({'career' => 'Navigator'})
      builder.reset 
      @crew['engineers']  = Array.new
      @ship.engineer_count.times {
        @crew['engineers'] << builder.setup({'career' => 'Engineer'})
        builder.reset 
      }
     
      if @ship.steward?
        @crew['steward'] = builder.setup({'career' => 'Steward'})
        builder.reset 
      end 

      if @ship.medic?
        @crew['medic'] = builder.setup({'career' => 'Medic'})
        builder.reset 
      end

      @crew['gunners'] = Array.new
      @ship.gunner_count.times {
        @crew['gunners'] << builder.setup({'career' => 'Gunner'})
        builder.reset
      }
    end

    def build_ship(params)
      @params       = params
      ship_data = Hash.new
      ship_builder  = FTLTools::ShipBuilder.new
      @ship         = ship_builder.setup(@params)
    end
 
    post('/crew') do
      build_ship(params)
      build_crew
      erb :crew
    end

    get('/build') do
      erb :build
    end

  end

end
