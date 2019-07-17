# character_builder_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'a built character' do
    let(:character) { 
      builder = CharacterBuilder.new
      builder.setup()
    }

    it 'has a name' do
      expect(character.name).to_not be_nil
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

    it 'can make different characters' do
      char    = {'name' => 'Wilbur'}
      builder = CharacterBuilder.new
      new_character = builder.setup(char)
      expect(new_character.name).to eq('Wilbur')
    end

    it 'can add skills by a limited set of careers' do
      # Needs more careers and tests.
      # Add some skills based on Soc.
      # Where to deal with the number of terms?
      # Test the pilot
      char    = {'career' => 'Pilot'}
      builder = CharacterBuilder.new
      new_character = builder.setup(char)
      expect(new_character.skills).to include("Pilot")
    end

  end
end

