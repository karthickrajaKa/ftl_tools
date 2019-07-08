# crewgen_spec.rb

require 'rack/test'

RecordResult = Struct.new(:success?)

RSpec.describe 'crewgen' do
  
  include Rack::Test::Methods
  
  it 'returns a 200 status for /crew' 

end

    
