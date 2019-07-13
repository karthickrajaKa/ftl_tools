# ship_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'a ship' do
    let ( :ship ) { FTLTools::Ship.new }

    it 'has a name' do
      ship.name = 'Miss Rosa'
      expect(ship.name).to eq('Miss Rosa')
    end

    it 'has a hull size' do
      ship.hull_size = 200
      expect(ship.hull_size).to eq(200)
    end

    it 'has a drive size' do
      ship.drive_size = 35
      expect(ship.drive_size).to eq(35)
    end

    it 'can hold passengers' do
      ship.passengers = 2
      expect(ship.passengers).to eq(2)
    end

    it 'can hold cargo' do
      ship.hold_size = 20
      expect(ship.hold_size).to eq(20)
    end

    it 'has weapons' do
      ship.weapons = { 'beam_laser' => 1, 'missile' => 1 }
      expect(ship.weapons).to eq({'beam_laser' => 1, 'missile' => 1})
    end

    it 'can classify itself as Navy, Merchant Marine, or Free Trader' do
      ship.service = 'Merchant Marine'
      expect(ship.service).to eq('Merchant Marine')
    end

    it 'can calculate engineers required' do
      ship.drive_size = 36
      expect(ship.engineer_count).to eq(2)
    end

    it 'can decide if a steward is needed' do
      ship.passengers = 1
      expect(ship.steward?).to be true
    end

    it 'can decide if a medic aboard is needed' do
      ship.hull_size = 200
      expect(ship.medic?).to be true
    end


  end
end
