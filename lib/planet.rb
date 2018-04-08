# planet.rb
# Trying to figure out the math of gravity, density, etc.
# Values are moderated to provide a potentially long term 
# habitable planet.

# Bibilography
#   http://pubs.usgs.gov/gip/interior/
#   "G" - https://en.wikipedia.org/wiki/Gravitational_constant

class Planet
  G           = 6.674e-11
  PI          = 3.14
  MIN_GRAVITY = 0.5
  MAX_GRAVITY = 1.5
  ERTH_DENSE  = 5.514e3

  attr_reader   :gravity, :radius, :uwp, :volume

  def initialize(uwp = nil)
    @uwp      = uwp ||= gen_uwp
    @size     = @uwp[1].to_i(16)
    @atmo     = @uwp[2].to_i(16)
    @hydro    = @uwp[3].to_i(16)
    @radius   = radius
    @volume   = volume
    @density  = density
    @mass     = mass
  end

  def roll(min, max)
    roll  = rand(1..6) + rand(1..6)
    roll  = [max, roll].min
    roll  = [min, roll].max
  end
    
  def gen_uwp
    Random.new_seed
    uwp   = 'X'
    3.times { uwp += roll(1,10).to_s(16).upcase }
    uwp += '000'
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
      0
    else
      (4 / 3.0) * PI * cube(@radius)
    end
  end

  def density
    if @size == 0
      0
    else
      ERTH_DENSE * (1 + atmo_mod - size_mod)
    end
  end 

  def mass
    @volume * @density
  end

  def gravity
    if @size == 0
      g = 0
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

  def square(num)
    num * num
  end

  def cube(num)
    num * num * num
  end

end
