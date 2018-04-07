# planet.rb
# Trying to figure out the math of gravity, density, etc.

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

  def initialize(uwp = '777777')
    @uwp      = uwp
    @size     = @uwp[0].to_i(16)
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
    if @uwp[0].to_i(16) == 0
      g = 0
    else
      g   = 1 + atmo_mod + size_mod
      g   = [g, MAX_GRAVITY].min
      g   = [g, MIN_GRAVITY].max
    end
  end

  def atmo_mod
    atmo = @uwp[1].to_i(16)
    case
      when [0,1].include?(atmo) then -0.75
      when [2,3].include?(atmo) then -0.50
      when [4,5].include?(atmo) then -0.25
      when [8,9].include?(atmo) then 0.25
      else  0
    end
  end

  def size_mod
    size = @uwp[0].to_i(16)
    case
      when size < 3 then -0.5
      when size < 5 then -0.25
      when size > 8 then 0.25
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
