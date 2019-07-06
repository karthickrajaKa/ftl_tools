# character_builder_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'a built character' do
    let(:character) { 
      char    = {'name' => 'Al'}
      builder = CharacterBuilder.new(char)
      builder.character
    }

    it 'has a name' do
      expect(character.name).to eq('Al')
    end

    it 'has a gender' do
      expect(['M','F']).to include(character.gender)
    end

    it 'has a culture' do
      expect(character.culture).to eq('humaniti')
    end

    it 'has a six digit hash' do
      expect(character.upp.length).to be == 6
      expect(character.upp.class).to eq(Hash)
    end

  end
end

