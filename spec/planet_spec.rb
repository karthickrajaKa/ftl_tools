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
    expect(dense_atmo.atmo_mod).to eq(0.25)
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
    expect(large.size_mod).to eq(0.25)
    otherwise     = Planet.new('777777')
    expect(otherwise.size_mod).to eq(0)
  end

  it 'has a density' do
    reducer           = 1000
    average           = Planet.new('345777')
    average_reduced   = average.density / reducer
    expect(average_reduced).to eq(5.514)
    min               = Planet.new('947777')
    min_reduced       = min.density / reducer
    expect(min_reduced).to eq(2.757)
    max               = Planet.new('287777')
    max_reduced       = max.density / reducer
    expect(max_reduced).to eq(9.6495)
    asteroid          = Planet.new('077777')
    asteroid_reduced  = asteroid.density / reducer
    expect(asteroid_reduced).to eq(0)
  end

  it 'has a gravity' do
    asteroid      = Planet.new('077777')
    expect(asteroid.gravity).to eq(0)
    average       = Planet.new('777777')
    expect(average.gravity).to eq(1)
    small         = Planet.new('477777')
    expect(small.gravity).to eq(0.75)
    very_small    = Planet.new('477777')
    expect(very_small.gravity).to eq(0.75)
    large_dense   = Planet.new('997777')
    expect(large_dense.gravity).to eq(1.5)
  end 
end

