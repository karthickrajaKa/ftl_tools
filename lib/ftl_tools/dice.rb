# FTLTools::Dice

module FTLTools
  # Provides basic random number generation.

	class Dice

    # Roll of 1d6.
		def roll_1
			rand(1..6)
		end

    # Roll of 2d6.
		def roll_2
			roll_1 + roll_1
		end

    # Roll of 1d6 for the first digit, and 1d6 for the second digit.
		def roll_66
			roll = roll_1.to_s + roll_1.to_s
			roll.to_i
		end

    # Provide a number of rolls of a similar type.
    def roll_several(num = 1, dice = 2)
      rolls = []
      num.times do
        case dice
        when 1
          rolls << roll_1
        when 2
          rolls << roll_2
        when 66
          rolls << roll_66
        end
      end
      rolls
    end

	end
end
