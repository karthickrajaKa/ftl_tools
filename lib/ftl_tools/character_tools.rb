# FTLTools::CharacterTools

module FTLTools
  # CharacterTools implements modules for modifying Character objects.
  # These methods are outside career data sets.
  module CharacterTools
    # In theory this is where we keep the data.
    DATA_PATH = File.expand_path('../../data', __dir__)

		# havenwood, fixed the freeze.
    NOBILITY = {
      11 => { 'F' => 'Dame',     'M' => 'Knight' }.freeze,
      12 => { 'F' => 'Baroness', 'M' => 'Baron' }.freeze,
      13 => { 'F' => 'Marquesa', 'M' => 'Marquis' }.freeze,
      14 => { 'F' => 'Countess', 'M' => 'Count' }.freeze,
      15 => { 'F' => 'Duchess',  'M' => 'Duke' }.freeze
    }.freeze

    def dice
      @dice ||= FTLTools::Dice.new
    end
		module_function :dice

    def roll_1
      dice.roll_1
    end
    module_function :roll_1

    def roll_2
      dice.roll_2
    end
		module_function :roll_2

    def roll_66
      dice.roll_66
    end
    module_function :roll_66

    def upp_to_s(upp = @upp)
		# havenwood:  upp.each_slice(7).flat_map { ... 
		#	.join
		# leitz: Not sure I get that yet.

      my_str  = ''
      counter = 1
      upp.each_pair do |_k, v|
        my_str << '-' if counter == 7
        my_str << v.to_s(16).upcase
        counter += 1
      end
      my_str
    end

    def generate_upp
			# havenwood, fixed.
      upp = %i[str dex end int edu soc].map {|stat|
				[stat, roll_2]}.to_h
      upp
    end

    def upp_s_to_h(upp_s)
			# havenwood, fixed hex.
      upp_a       = upp_s.split('')
      upp_h       = {}
      upp_h[:str] = upp_a[0].hex
      upp_h[:dex] = upp_a[1].hex
      upp_h[:end] = upp_a[2].hex
      upp_h[:int] = upp_a[3].hex
      upp_h[:edu] = upp_a[4].hex
      upp_h[:soc] = upp_a[5].hex
      upp_h
    end

    def generate_gender
      %w[M F].sample
    end

    def generate_traits
      traits = []
      traits << get_random_line_from_file('positive_traits.txt')
      traits << get_random_line_from_file('negative_traits.txt')
    end

    def generate_appearence
      app = ''
      app << generate_hair + ' hair, '
      app << generate_skin + ' skin'
    end

    def generate_hair
			# havenwood mentioned dropping the begin,
			# is the 'end' kept? 
			# Currently tests are broken.
      begin
				t = get_random_line_from_file('hair_tone.txt')
				b = get_random_line_from_file('hair_body.txt')
				c = get_random_line_from_file('hair_colors.txt')
				l = get_random_line_from_file('hair_length.txt')
			  new_hair = "#{b} #{t} #{c} #{l}"
      rescue SystemCallError
        new_hair = 'Straight medium brown short'
      end
    end

    def generate_skin
      begin
				skin_tone = get_random_line_from_file('skin_tones.txt')
      rescue SystemCallError
        skin_tone = 'medium'
      end
    end

    def generate_name(options)
      Name.new(options).to_s
    end

    def generate_species
			# havenwood, as noted this will change sooner or later.
			# and humaniti is the proper in-game spelling.  :)
      'humaniti'
    end

    def social_status(upp = @upp)
			# havenwood, fixed.
      case upp[:soc]
				when 0..5   then  'other'
				when 11..15 then  'noble'
				else 'citizen'
      end
    end

    def noble?
			# Yay! Something looked good!
      @upp[:soc] > 10
    end

    def title(upp = @upp, gender = @gender)
			# havenwood, fixed.
      soc = upp[:soc]
      NOBILITY[soc][gender] if NOBILITY.key?(soc)
    end

    def roll_several(num = 1, dice = 2)
			# havenwood, I need to think through this one.
			# It may also move elsewhere.
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

    # Takes a hash of Character object, skill, and optional level to increase.
    # Returns the modified Character object.
    # If the "skill" to be modified is a Stat, calls modify_stat.
    def increase_skill(options)
			# This should eventually change to not need the character object. 
			# Maybe.
      character = options['character']
      skill     = options['skill']
      level     = options.key?('level') ? options['level'] : 1
      if skill.split.length > 1
        stat_options 				= Hash.new
				stat_options[:upp]	= character.upp
				stat_options[:mod]	= skill
        modify_stat(stat_options)
      else
        if character.skills.key?(skill)
          character.skills[skill] += level
        else
          character.skills[skill] = level
        end
      end
    end
		module_function :increase_skill

    # Takes a hash of the UPP and the modifier, for example "+2 Int".
    # Returns a hash of the modified UPP, within the game's 2-15 limits.
    def modify_stat(options)
			# havenwood, trying to remember why I used the ArgumentError.
			# This one uses + and - input.
			# Changing this completely, it needs the stat mod and UPP hash,
			# returns UPP hash.
			upp		= options[:upp]
			mod		= options[:mod]
			level	= mod.split[0].to_i
			stat	= mod.split[1].downcase.to_sym
			upp[stat] = upp[stat] + level
			upp[stat] = [upp[stat], 15].min
			upp[stat] = [upp[stat], 2].max
			upp
    end
		module_function :modify_stat

    def array_from_file(file)
      # Still need to work on this.
      # Block the tracebacks if possible.
			# havenwood, removed the $
      fname = DATA_PATH + '/' + file
      raise MissingFile, "No #{fname} file, sorry." unless File.readable?(fname)
      new_file    = File.open(fname, 'r')
      new_array   = []
      new_file.each do |line|
        line = line.strip
        new_array << line if line !~ /#/ && (line.length > 1)
      end
      new_file.close
      new_array
    end
		module_function :array_from_file

    def get_random_line_from_file(file)
      # Still need to work on this.
      # Block the tracebacks if possible.
      fname = DATA_PATH + '/' + file
      begin
        new_file    = File.open(fname, 'r')
        new_array   = []
        new_file.each do |line|
          line.chomp!
          new_array << line if line !~ /#/ && (line.length > 4)
        end
        return new_array.sample.strip
      rescue IOError
        raise MissingFile, "No #{fname} file, sorry."
      ensure
        new_file.close unless new_file.nil?
      end
    end

    def generate_plot
      [get_random_line_from_file('plots.txt'), rand(1..6)]
    rescue SystemCallError
      ['Some drab plot', rand(1..6)]
    end

    def generate_temperament
			# havenwood, fixed the return.
      begin
        temperament = get_random_line_from_file('temperaments.txt')
      rescue SystemCallError
        temperament = 'Boring'
      end
    end

    # def self.morale(options = "")
    def morale(options = '')
      morale = roll_1
      if (options.class == Hash) && !options['character'].careers.empty?
        high_morales    = %w[Marine Army Firster]
        medium_morales  = %w[Navy Scout]
        options['character'].careers.each do |career, terms|
          morale += (1 * terms)      if high_morales.include?(career)
          morale += (0.5 * terms)    if medium_morales.include?(career)
        end
      end
      morale
    end

    def upp_mod(upp, stat)
      case upp[stat]
      when 15
        3
      when 13..14
        2
      when 10..12
        1
      when 3..5
        -1
      when 1..2
        -2
      else
        0
      end
    end

    def skill_mod(skills, skill, assume_zero = false)
      skill_value = if skills.key?(skill)
                      skills[skill]
                    elsif assume_zero
                      0
                    else
                      -3
                    end
      skill_value
    end

    def roll_mod(char, skill, stat, assume_zero = false)
      total_mod = skill_mod(char.skills, skill, assume_zero) + upp_mod(char.upp, stat)
      total_mod
    end
  end
end
