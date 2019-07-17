# character_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'a basic character' do
    let(:person) { FTLTools::Character.new }

    it 'has a name' do
      person.name     = 'Al Lefron'
      expect(person.name).to eq('Al Lefron')
      expect(person.first_name).to eq('Al')
      expect(person.last_name).to eq('Lefron') 
    end

    it 'has a culture' do
      person.culture  = 'humaniti'
      expect(person.culture).to eq('humaniti')
    end

    it 'has a gender' do
      person.gender   = 'F'
      expect(person.gender).to eq('F')
    end

    it 'can render a hash upp to a string' do
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 12 }
      expect(person.upp_to_s).to eq('77A65C')
    end

    it 'can render a string upp to a hash' do
      upp_s   = '77A65C'
      expect(person.upp_s_to_h(upp_s)).to eq({str: 7, dex: 7, end: 10, int: 6, edu: 5, soc:12})
    end

    it 'can determine the social status of a character' do
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 12 }
      expect(person.social_status).to eq('noble')
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 2 }
      expect(person.social_status).to eq('other')
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 7 }
      expect(person.social_status).to eq('citizen')
    end

    it 'can identify a noble' do
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 12 }
      expect(person.noble?).to be == true
    end

    it 'can provide a proper title' do
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 12 }
      person.gender   = 'F'
      expect(person.title).to eq('Baroness')
    end

    it 'can return a modifier from a stat' do
      person.upp      = { str: 7, dex: 7, end: 10, int: 6, edu:5, soc: 12 }
      expect(person.upp_mod(:soc)).to eq(1)
    end

    it 'can add and show a skill list' do
      person.add_skill("Blade")
      person.add_skill("GunCbt", 2)
      expect(person.skills).to eq("Blade-1, GunCbt-2")
    end      

  end
end

