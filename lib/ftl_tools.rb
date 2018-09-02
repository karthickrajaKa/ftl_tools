# ftl_tools.rb
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

module FTL_Tools
  
  require 'csv'
  require 'json'
  require 'fileutils'

  def string_to_alnum(string)
    # Turns a string into an alphanumeric string.
    # Spaces become underscores, non-alnum characters are removed.

    new_string = ""
    string.each_char { |c|
      new_string += c.downcase if c =~ /[A-Za-z]/
      new_string += '_' if c == ' '
      new_string += c if c =~ /[0-9]/
    }
    new_string
  end
  module_function :string_to_alnum

  def make_dir(dir)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
  end  
  module_function :make_dir
 
  def get_data(data_dir, file)
    # Should be combined with #get_data_csv
    data_file = data_dir + '/' + file
    obj       = File.read(data_file)
    data      = JSON.parse(obj)
    return    data
  end
  module_function :get_data 

  def get_data_csv(data_dir, file)
    data_file = data_dir + '/' + file
    data = Array.new
    CSV.open(data_file, 'r', {:col_sep => ':'}).each { |row|
      data << row
    }
    data
  end
  module_function :get_data_csv

  def array_of_planets(data_dir, file)
    require 'planet'
    planet_data = get_data_csv(data_dir, file)
    planets = Array.new
    planet_data.each {|p|
      planet_hash = {'name' => p[0], 'uwp' => p[1], 'location' => p[2]}
      planets << Planet.new(planet_hash)
    }    
    planets
  end
  module_function :array_of_planets

  def get_cargo_options(data_dir, file)
    require 'cargo'
    cargo_data = get_data_csv(data_dir, file)
    cargo = Hash.new
    cargo_data.each {|c|
      c[0].start_with?('#') ? next : name = c[0]
      base_price  = c[1]
      dt_per_unit = c[2]
      sell_mods   = hash_from_string(c[3])
      buy_mods    = hash_from_string(c[4])
      cargo_hash = {'name' => name, 'base_price' => base_price,
        'sell_mods' => sell_mods, 'buy_mods' => buy_mods}
      cargo[name] = Cargo.new(cargo_hash)
    }
    cargo
  end
  module_function :get_cargo_options

  # Takes a string, and an optional seperator (default is ',').
  # Returns a hash with a string key and int value
  def hash_from_string(string = nil, sep = ',')
    data_hash = Hash.new
    return data_hash if string.nil?
    string_array = string.split(sep)
    string_array.each {|item|
      item_array  = item.split()
      key         = item_array[0]
      value       = item_array[1].to_i
      data_hash[key] = value
    }
    data_hash
  end
  module_function :hash_from_string 

	def hex_to_int(number)
		number = number.upcase unless number.nil?
		if ("0".."9").include?(number)
			number = number.to_i
		elsif ("A".."F").include?(number)
			number = number.to_i(16)
		else
			number = nil
		end
		number
	end
	module_function :hex_to_int
  def read_user_input
    gets.chomp
  end
  module_function :read_user_input

  def roll(dice = 2)
    num = 0
    dice.times {
      num += rand(1..6)
    }
    num 
  end
  module_function :roll

  def roller(roll_string)
    if roll_string.index(/[\+-]/).nil?
      modifier = 0
    else
      modi     =   roll_string.index(/[\+-]/)
      modifier = roll_string[modi..-1].to_i
    end

    d_index     = roll_string.index('d')
    if d_index == 0
      dice_num    = 1
    else
      dice_num    = roll_string[0...d_index].to_i
    end
    dice_type     = roll_string[d_index + 1..-1].to_i

    roll = modifier
    dice_num.times {
      roll += rand(1..dice_type)
    }
    return roll
  end
  module_function :roller

  def trimmed_roll(num, min, max)
    my_roll = roll(num) 
    my_roll = [max, my_roll].min
    my_roll = [min, my_roll].max
    my_roll
  end
  module_function :trimmed_roll

  def square(num)
    num * num
  end
  module_function :square

  def cube(num)
    num * num * num
  end
  module_function :cube

end
