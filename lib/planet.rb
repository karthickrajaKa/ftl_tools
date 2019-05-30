#planet.rb

## DEPRECATED  See free_trader repository.


# Trying to figure out the math of gravity, density, etc.
# Values are moderated to provide a potentially long term 
# habitable planet.

# Bibilography
#   http://pubs.usgs.gov/gip/interior/
#   "G" - https://en.wikipedia.org/wiki/Gravitational_constant


require 'ftl_tools'

class Planet
  G           = 6.674e-11
  PI          = 3.14
  MIN_GRAVITY = 0.5
  MAX_GRAVITY = 1.5
  ERTH_DENSE  = 5.514e3

  attr_reader :name, :location, :uwp

  def initialize(data)
    @name     = data['name']      || "Unknown"
    @uwp      = data['uwp']       || gen_uwp
    @location = data['location']  || "XXXX"
    dirt_math
  end

  def dirt_math
    @size     = FTL_Tools.hex_to_int(@uwp[1])
    @atmo     = FTL_Tools.hex_to_int(@uwp[2])
    @hydro    = FTL_Tools.hex_to_int(@uwp[3])
    @radius   = radius
    @volume   = volume
    @density  = density
    @mass     = mass
  end

  def gen_uwp
    Random.new_seed
    uwp = 'X'
    3.times {
      uwp += FTL_Tools.trimmed_roll(2,1,10).to_s(16).upcase
      uwp += '000'
    }
    uwp
  end

  def radius
    if @size == 0
      @size
    else
       @size * 800
    end
  end 

  def volume
    if @size == 0
      @size
    else
      ((4 / 3.0) * PI * FTL_Tools.cube(@radius)).to_i
    end
  end

  def density
    if @size == 0
      @size
    else
      # This might not make sense. 
      # Need to also account for a multiplier of 0.
      ERTH_DENSE * (1 + atmo_mod - size_mod)
    end
  end 

  def mass
    @volume * @density
  end

  def gravity
    if @size == 0
      g = @size
    else
      g   = 1 + atmo_mod + size_mod
      g   = [g, MAX_GRAVITY].min
      g   = [g, MIN_GRAVITY].max
    end
  end

  def atmo_mod
    case
      when [0,1].include?(@atmo) then -0.75
      when [2,3].include?(@atmo) then -0.50
      when [4,5].include?(@atmo) then -0.25
      when [8,9].include?(@atmo) then 0.25
      else  0
    end
  end

  def remote_scan
    "X" + @size.to_s + "X" + @hydro.to_s + "000"
  end

  def size
    @size
  end

  def size_mod
    case
      when @size <= 3 then -0.5
      when @size <= 5 then -0.25
      when @size >= 8 then 0.25
      else 0
    end
  end

  def trade_codes
    # Yeah, really bogus. Will calculate more when I have the 
    # Other processes working. 
    ['Ag']
  end

  def to_s
    trade_code_string = trade_codes.join(' ')
    "#{@name}: UWP #{@uwp}, Location: #{@location}, Trade: #{trade_code_string}"
  end

end  
