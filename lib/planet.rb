#planet.rb

require 'ftl_tools'

class Planet

  G           = 6.674e-11
  PI          = 3.14
  MIN_GRAVITY = 0.5
  MAX_GRAVITY = 1.5
  ERTH_DENSE  = 5.514e3

  attr_reader :name, :location, :uwp

  def initialize(data)
    @name     = data['name']
    @uwp      = data['uwp']
    @location = data['location']
    dirt_math
  end

  def dirt_math
    @size     = @uwp[1].to_i(16)
    @atmo     = @uwp[2].to_i(16)
    @hydro    = @uwp[3].to_i(16)
    @radius   = radius
    @volume   = volume
    @density  = density
    @mass     = mass
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

  def size_mod
    case
      when @size < 3 then -0.5
      when @size < 5 then -0.25
      when @size > 8 then 0.25
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
