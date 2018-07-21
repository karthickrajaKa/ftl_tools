# tc_planet.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require "test/unit"
require "fileutils"
#require "ftl_tools"
require "planet"

class TestPlanet < Test::Unit::TestCase

  def setup
    average_data  = {'name' => 'Average',
      'uwp'       => 'X777000',
      'location'  => '777'}
    asteroid_data = {'name' => 'Asteroid',
      'uwp'       => 'X000000',
      'location'  => '000'}
    small_data    = {'name' => 'Small', 
      'uwp'       => 'X121000', 
      'location'  => '111'}
    medium_data   = {'name' => 'Medium',
      'uwp'       => 'X555000',
      'location'  => '555'}
    large_data    = {'name' => 'Large',
      'uwp'       => 'X999000',
      'location'  => '999'}
    @average      = Planet.new(average_data) 
    @asteroid     = Planet.new(asteroid_data)
    @small        = Planet.new(small_data)
    @medium       = Planet.new(medium_data)
    @large        = Planet.new(large_data)
  end

  def test_atmo_mod
    assert(@average.atmo_mod  ==  0)
    assert(@asteroid.atmo_mod == -0.75)
    assert(@small.atmo_mod    == -0.50)
    assert(@medium.atmo_mod   == -0.25)
    assert(@large.atmo_mod    ==  0.25)
  end
  
  def test_density
    # The method is probably broken.
    assert(@average.density   == 5514.0)
    assert(@asteroid.density  == 0)
    assert(@small.density     == 5514.0)
    assert(@medium.density    == 5514.0) 
    assert(@large.density     == 5514.0)
  end

  def test_dirt_math
    assert(@average.size      == 7)
  end

  def test_gen_uwp
    empty_data = Hash.new
    p = Planet.new(empty_data)
    p_uwp = p.uwp
  end

  def test_gravity
    assert(@average.gravity   == 1)    
    assert(@asteroid.gravity  == 0)
    assert(@small.gravity     == 0.5)
    assert(@medium.gravity    == 0.5)
    assert(@large.gravity     == 1.5)
  end

  def test_mass
    assert(@average.mass    == 4054144532478162)
    assert(@asteroid.mass   == 0)
    assert(@small.mass      == 11819663358162)
    assert(@medium.mass     == 1477457919996324)
    assert(@large.mass      == 8616534589440000)
  end

  def test_radius
    assert(@average.radius  == 5600)
    assert(@asteroid.radius == 0)
    assert(@small.radius    == 800)
    assert(@medium.radius   == 4000)
    assert(@large.radius    == 7200)
  end

  def test_remote_scan
    assert(@average.remote_scan   == "X7X7000")
    assert(@asteroid.remote_scan  == "X0X0000")
    assert(@small.remote_scan     == "X1X1000")
    assert(@medium.remote_scan    == "X5X5000")
    assert(@large.remote_scan     == "X9X9000")
  end

  def test_size_mod
    assert(@average.size_mod  ==  0)
    assert(@asteroid.size_mod == -0.5)
    assert(@small.size_mod    == -0.5)
    assert(@medium.size_mod   == -0.25)
    assert(@large.size_mod    ==  0.25)
  end

  def test_volume
    assert(@average.volume  == 735245653333)
    assert(@asteroid.volume == 0)
    assert(@small.volume    == 2143573333)
    assert(@medium.volume   == 267946666666)
    assert(@large.volume    == 1562664960000)
  end

  def test_to_s
    assert(@average.to_s == "Average: UWP X777000, Location: 777, Trade: Ag")
  end

  def test_trade_codes
    assert(@average.trade_codes == ['Ag'])
  end

end
