# tc_planet.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require "test/unit"
require "fileutils"
#require "ftl_tools"
require "planet"

class TestPlanet < Test::Unit::TestCase

  def setup
    asteroid_data = {'name' => 'Asteroid',
      'uwp'       => '000000',
      'location'  => '000'}
    small_data    = {'name' => 'Small', 
      'uwp'       => '111000', 
      'location'  => '111'}
    medium_data   = {'name' => 'Medium',
      'uwp'       =>  '555000',
      'location'  => '555'}
    large_data    = {'name' => 'Large',
      'uwp'       => '999000',
      'location'  => '999'}
    @asteroid      = Planet.new(asteroid_data)
    @small         = Planet.new(small_data)
    @medium        = Planet.new(medium_data)
    @large         = Planet.new(large_data)
  end

  def test_radius
    assert(@asteroid.radius == 0)
    assert(@small.radius    == 800)
    assert(@medium.radius   == 4000)
    assert(@large.radius    == 7200)
  end

  def test_volume
    assert(@asteroid.volume == 0)
    assert(@small.volume    == 2143573333)
    assert(@medium.volume   == 267946666666)
    assert(@large.volume    == 1562664960000)
  end

end
