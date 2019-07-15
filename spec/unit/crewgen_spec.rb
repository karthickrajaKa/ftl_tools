# crewgen_spec.rb

require 'rack/test'
require 'ftl_tools'

module FTLTools

  RecordResult = Struct.new(:success?)

  RSpec.describe 'crewgen' do
    include Rack::Test::Methods
   
    def app
      CrewGen.new
    end 

    it 'returns a 200 status for /crew' do
      post '/crew'
      expect(last_response.status).to eq(200)
    end

    it 'has a pilot' do
      post '/crew'
      expect(last_response.body).to include('Pilot')
    end

  end

end    
