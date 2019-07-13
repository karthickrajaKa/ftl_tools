# ship_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'a ship builder' do
    let ( :ship_builder ) { ShipBuilder.new }

    it 'gives a ship a name' do
      data = {'name' => 'Miss Rosa'}
      ship = ship_builder.setup(data)
      expect(ship.name).to eq('Miss Rosa')
    end
  
    it 'lays out the hull' do
      data = { 'hull_size' => 300 }
      ship = ship_builder.setup(data)
      expect(ship.hull_size).to eq(300)
    end

    it 'adds in the drives' do
      data = { 'drive_size' => 30 }
      ship = ship_builder.setup(data)
      expect(ship.drive_size).to eq(30)
    end

    it 'install weapons' do
      data = { 'weapons' => 2 }
      ship = ship_builder.setup(data)
      expect(ship.weapons).to eq(2)
    end

    it 'configures cargo space' do
      data = { 'hold_size' => 20 }
      ship = ship_builder.setup(data)
      expect(ship.hold_size).to eq(20)
    end

    it 'specifies service of origin' do
      data = { 'service' => 'Free Trader' }
      ship = ship_builder.setup(data)
      expect(ship.service).to eq('Free Trader')
    end

    it 'boards passengers' do
      data = { 'passengers' => 2 }
      ship = ship_builder.setup(data)
      expect(ship.passengers).to eq(2)
    end

  end
end
