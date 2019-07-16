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
  end
end

