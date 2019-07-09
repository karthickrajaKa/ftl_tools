# crewgen_spec.rb

require 'rack/test'
require 'ftl_tools'

module FTLTools

  RecordResult = Struct.new(:success?)

  RSpec.describe 'crewgen' do
    
    include Rack::Test::Methods
    
    it 'returns a 200 status for /crew' 

  end

end    
