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
    @radius   = radius
    @volume   = volume
    
    #@density  = density
    #@mass     = mass
  end

  def radius
    size    = @uwp[0].to_i(16)
    if size == 0
      return nil
    end
    size_in_miles = size * 1000
    size_in_miles * 0.8
  end 

  def volume
    (4 / 3.0) * PI * cube(@radius)
  end

  def density
    @density = ERTH_DENSE
  end 

  def mass
    @volume * @density
  end

  def gravity
    radius_in_meters = @radius * 1000
    puts("Mass is #{@mass}.")
    G * @mass / square(radius_in_meters)
  end

  def atmo_mod
    atmo = @uwp[1].to_i(16)
    @gravity_mod_atmo = case
      when [0,1].include?(atmo) then -0.75
      when [2,3].include?(atmo) then -0.50
      when [4,5].include?(atmo) then -0.25
      when [8,9].include?(atmo) then 1.25
      else  0
      end
  end

  def size_mod
    size = @uwp[0].to_i(16)
    @gravity_mod_size = case
      when size < 3 then -0.5
      when size < 5 then -0.25
      when size > 8 then 1.25
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
