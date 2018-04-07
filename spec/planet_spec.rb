# planet_spec.rb

require 'planet'

RSpec.describe 'a planet' do
  let (:planet) { Planet.new('888777') }

  it 'has a uwp' do
    expect(planet.uwp).to eq('888777')
  end

  it 'has a radius' do
    expect(planet.radius).to eq(6400)
  end
  
  it 'has a volume' do
    reducer         = 1000000000
    volume_reduced  = planet.volume.to_i / reducer
    expect(volume_reduced).to eq(1097)
  end

  it 'shows relevant atmo_mod' do
    no_atmo         = Planet.new('707777')
    expect(no_atmo.atmo_mod).to eq(-0.75)
    very_thin_atmo  = Planet.new('727777')
    expect(very_thin_atmo.atmo_mod).to eq(-0.5)
    thin_atmo       = Planet.new('747777')
    expect(thin_atmo.atmo_mod).to eq(-0.25)
    dense_atmo      = Planet.new('787777')
    expect(dense_atmo.atmo_mod).to eq(1.25)
    average_atmo    = Planet.new('777777')
    expect(average_atmo.atmo_mod).to eq(0)
    odd_atmo        = Planet.new('7C7777')
    expect(odd_atmo.atmo_mod).to eq(0)
  end

  it 'shows relevant size mod' do
    very_small    = Planet.new('177777')
    expect(very_small.size_mod).to eq(-0.5)
    small         = Planet.new('477777')
    expect(small.size_mod).to eq(-0.25)
    large         = Planet.new('977777')
    expect(large.size_mod).to eq(1.25)
    otherwise     = Planet.new('777777')
    expect(otherwise.size_mod).to eq(0)
  end

  it 'has a density' do
    pending 'need to build the math behind this first.'
  end


end

