# planet_spec.rb

require 'planet'

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/example.txt'
end

RSpec.describe 'a planet' do
  let (:average)        { Planet.new('X777777') }
  let (:no_atmo)        { Planet.new('X707777') }
  let (:very_thin_atmo) { Planet.new('X727777') }
  let (:thin_atmo)      { Planet.new('X747777') }
  let (:dense_atmo)     { Planet.new('X787777') }
  let (:average_atmo)   { Planet.new('X777777') }
  let (:odd_atmo)       { Planet.new('X7C7777') }
  let (:very_small)     { Planet.new('X177777') }
  let (:large)          { Planet.new('X977777') }
  let (:min)            { Planet.new('X947777') }
  let (:max)            { Planet.new('X287777') }
  let (:asteroid)       { Planet.new('X077777') }
  let (:large_dense)    { Planet.new('X997777') }
  let (:small)          { Planet.new('X477777') }
  let (:rand)           { Planet.new()          }

  it 'has a uwp' do
    expect(average.uwp).to eq('X777777')
  end

  it 'has a radius' do
    expect(average.radius).to eq(5600)
  end
  
  it 'has a volume' do
    reducer         = 1000000000
    volume_reduced  = average.volume.to_i / reducer
    expect(volume_reduced).to eq(735)
  end

  it 'shows relevant atmo_mod' do
    expect(no_atmo.atmo_mod).to eq(-0.75)
    expect(very_thin_atmo.atmo_mod).to eq(-0.5)
    expect(thin_atmo.atmo_mod).to eq(-0.25)
    expect(dense_atmo.atmo_mod).to eq(0.25)
    expect(average_atmo.atmo_mod).to eq(0)
    expect(odd_atmo.atmo_mod).to eq(0)
  end

  it 'shows relevant size mod' do
    expect(very_small.size_mod).to eq(-0.5)
    expect(small.size_mod).to eq(-0.25)
    expect(large.size_mod).to eq(0.25)
    expect(average.size_mod).to eq(0)
  end

  it 'has a density' do
    reducer           = 1000
    average_reduced   = average.density / reducer
    expect(average_reduced).to eq(5.514)
    min_reduced       = min.density / reducer
    expect(min_reduced).to eq(2.757)
    max_reduced       = max.density / reducer
    expect(max_reduced).to eq(9.6495)
    asteroid_reduced  = asteroid.density / reducer
    expect(asteroid_reduced).to eq(0)
  end

  it 'has a gravity' do
    expect(asteroid.gravity).to eq(0)
    expect(average.gravity).to eq(1)
    expect(small.gravity).to eq(0.75)
    expect(very_small.gravity).to eq(0.5)
    expect(large_dense.gravity).to eq(1.5)
  end 

  it 'has a uwp if not given one' do
    expect(rand.uwp.length).to eq(7)
  end

end

