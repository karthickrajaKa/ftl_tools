# data_mine_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'the module provides' do
    include DataMine

    # This doesn't seem to work yet, or I don't know how to call it.
    DATA_PATH = File.expand_path('spec/', __dir__)

    it 'gives a random line from a file' do
      options = %w(Nice Nope Maybe Sorta Ugh)
      output = DataMine.get_random_line_from_file('spec/test_data.txt')
      expect(options).to include(output)
    end

    it 'provides an array from a file' do
      output = DataMine.array_from_file('spec/test_data.txt')
      expect(output.length).to be >= 3
    end
      
  end
end

