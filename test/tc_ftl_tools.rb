# tc_ftl_tools.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require "test/unit"
require "ftl_tools"
require "fileutils"

class TestFTL_Tools < Test::Unit::TestCase

  def setup
    @data_dir = 'test/data/games/crash_me'
    @ship = FTL_Tools.get_data(@data_dir, 'ship.json')
    @resources = FTL_Tools.get_data(@data_dir, 'resources.json')
    @crew = FTL_Tools.get_data(@data_dir, 'crew.json')
  end

  def test_array_from_file
    my_array = FTL_Tools.array_from_file('plots.txt')
    assert(my_array.class == Array)
    assert(my_array.length >= 1)
  end

  def test_array_of_planets
    planets   = Array.new
    data_dir  = 'test/data'
    file      = 'planets.csv'
    planets   = FTL_Tools.array_of_planets(data_dir, file)
    assert(planets.count == 3)
    assert(planets[0].class == Planet)
  end
  
  def test_get_cargo_options
    cargo     = Array.new
    data_dir  = 'test/data'
    file      = 'cargo.csv'
    cargo     = FTL_Tools.get_cargo_options(data_dir, file)
    assert(cargo.count == 6)
  end  

  def test_get_random_line_from_file
    line        = FTL_Tools.get_random_line_from_file('plots.txt')
    check_array = FTL_Tools.array_from_file('plots.txt')
    assert(check_array.include?(line))
  end

	def test_hex_to_int_int
		number	= "9"
		assert(FTL_Tools.hex_to_int(number) == 9)	
	end

	def test_hex_to_int_hex
		number	= "a"
		assert(FTL_Tools.hex_to_int(number) == 10)	
	end

	def test_hex_to_int_high_alpha
		number	= "G"
		assert(FTL_Tools.hex_to_int(number) == nil)	
	end
	
	def test_hex_to_int_low_num
		number	= "-1"
		assert(FTL_Tools.hex_to_int(number) == nil)	
	end

  def test_array_from_string_default_sep
    string  		= "In 2 Ri -3"
    test_array 	= ["In", "2", "Ri", "-3"]
    produced_array = FTL_Tools.array_from_string(string)
    assert(produced_array == test_array)
  end

  def test_array_from_string_colon_sep
    string  		= "In: 2: Ri: -3"
		sep					= ":"
    test_array 	= ["In", "2", "Ri", "-3"]
    produced_array = FTL_Tools.array_from_string(string, sep)
    assert(produced_array == test_array)
  end

  def test_hash_from_string
    string  = "In 2, Ri -3"
    test_hash = {"In" => 2, "Ri" => -3}
    produced_hash = FTL_Tools.hash_from_string(string, ',')
    assert(produced_hash == test_hash)
  end

  def test_string_to_alnum
    old_string = 'HOW now "Freddy"? You big (123 kg.) cow?'
    new_string = 'how_now_freddy_you_big_123_kg_cow'
    assert(FTL_Tools.string_to_alnum(old_string) == new_string)
  end

  def test_make_dir
    dir = 'test/data/games/my_ship_name'
    FTL_Tools.make_dir(dir)
    assert(File.directory?(dir))
    FileUtils.rmdir(dir)
  end

  def test_get_data
    assert(@ship['name'] == "Crash Me")
  end

  def test_get_data_csv
    # Fragile test, fails if data layout changes.
    data_dir = 'test/data'
    file      = 'planets.csv'
    planets   = FTL_Tools.get_data_csv(data_dir, file)
    assert(planets[0][0] == 'Birach')
  end

  # This is not a test, but a tool for test_read_user_input  
  def with_stdin
    stdin = $stdin
    $stdin, write = IO.pipe
    yield write
  ensure
    write.close
    $stdin = stdin
  end

  def test_read_user_input
    with_stdin { |user|
      user.puts 'user input'
      assert_equal(FTL_Tools.read_user_input, 'user input')
    }
  end
 
  def test_roll_default
    rolls = []
    1000.times {
      rolls << FTL_Tools.roll
    }
    assert_equal(rolls.min, 2)
    assert_equal(rolls.max, 12)
  end 

  def test_roll_1
    rolls = []
    1000.times {
      rolls << FTL_Tools.roll(1)
    }
    assert_equal(rolls.min, 1)
    assert_equal(rolls.max, 6)
  end

  def test_square
    assert_equal(100, FTL_Tools.square(10))
  end

  def test_cube
    assert_equal(27, FTL_Tools.cube(3))
  end
 
  def test_roller_with_num_dice_and_modifier
    1000.times {
      roll_string = '2d6+3'
      min         = 5
      max         = 15
      roll        = FTL_Tools.roller(roll_string)
      assert((min..max) === roll)
    }
  end

  def test_roller_with_num_dice_no_modifier
    1000.times {
      roll_string = '2d6'
      min         = 2
      max         = 12
      roll        = FTL_Tools.roller(roll_string)
      assert((min..max) === roll)
    }
  end

  def test_roller_with_no_num_dice_no_modifier
    1000.times {
      roll_string = 'd6'
      min         = 1
      max         = 6
      roll        = FTL_Tools.roller(roll_string)
      assert((min..max) === roll)
    }
  end

  def test_trimmed_roll
    1000.times {
      min   = 6
      max   = 8
      roll = FTL_Tools.trimmed_roll(2,min,max)
      assert((min..max) === roll)
    }
  end
end
