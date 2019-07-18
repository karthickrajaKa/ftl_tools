# character.rb

#require 'ftl_tools'

module FTLTools

  # Provides the basic character object.
  class Character

    # Constant for the social rank designations.
    NOBILITY = { 
      11 => { 'F' => 'Dame',     'M' => 'Knight' }.freeze,
      12 => { 'F' => 'Baroness', 'M' => 'Baron' }.freeze,
      13 => { 'F' => 'Marquesa', 'M' => 'Marquis' }.freeze,
      14 => { 'F' => 'Countess', 'M' => 'Count' }.freeze,
      15 => { 'F' => 'Duchess',  'M' => 'Duke' }.freeze
    }.freeze

    attr_accessor :culture, :gender, :name, :upp

    def initialize
      @skills = Hash.new
    end

    # Return an alphabetic sorted list of skills.
    def skills
      skill_list = ""
      @skills.sort.each { |k,v|
        if skill_list.length > 0
          skill_list += ", "
        end
        skill_list += "#{k}-#{v}"
      }
      skill_list
    end

    # Add skills
    def add_skill(skill, level = 1)
      level = level.to_i
      if @skills.key?(skill)
        @skills[skill] += level
      else
        @skills[skill] = level
      end
    end
      
    def modify_stat(stat, level = 1)

    end
 
    # Boolean, true if Noble.
    def noble?
      @upp[:soc] > 10
    end

    # Generic social class, (other, citizen, noble).
    def social_status
      case @upp[:soc]
        when 0..5   then 'other'
        when 11..15 then 'noble'
        else 'citizen'
      end
    end

    # Return the title, if noble.
    def title
      NOBILITY[@upp[:soc]][@gender]
    end

    # Return an int modifier based on stat.
    def upp_mod(stat)
      case upp[stat]
        when 15     then 3
        when 13..14 then 2
        when 10..12 then 1
        when  3..5  then -1
        when  1..2  then -2
        else 0
      end
    end

    # Convert a hash upp to a string
    def upp_to_s(upp = @upp)
      my_str = ''
      counter = 1
      upp.each_pair { |k,v|
        my_str  << '-' if counter == 7
        my_str  << v.to_s(16).upcase
        counter += 1 
      }
      my_str
    end

    # Convert a string upp to a hash.
    def upp_s_to_h(upp_s)
      upp_a       = upp_s.split('')
      upp_h       = Hash.new(0)
      upp_h[:str] = upp_a[0].hex
      upp_h[:dex] = upp_a[1].hex
      upp_h[:end] = upp_a[2].hex
      upp_h[:int] = upp_a[3].hex
      upp_h[:edu] = upp_a[4].hex
      upp_h[:soc] = upp_a[5].hex
      upp_h 
    end    

    # Return the first part of the name.
    def first_name
      @name.split(/ /)[0] 
    end

    # Return the last part of the name.
    def last_name
      @name.split(/ /)[-1]
    end

  end
end

