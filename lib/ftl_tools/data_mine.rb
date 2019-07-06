# data_mine.rb

module FTLTools

  # Allows getting data from storage.
  module DataMine

    # Return a string, without newline, from a multi-line file.
    def get_random_line_from_file(file)
      begin
        lines = Array.new
        File.open(file) { |file|
          file.readlines.each { |line|
            line = line.chomp 
            next if line.start_with?('#') or line.length < 2
            lines << line 
          }
        }
        lines.sample
      rescue IOError => e
        puts "File error:  #{e}."
        exit
      end
    end  
    module_function :get_random_line_from_file

    # Return an array of strings, without newlines, from a multi-line file. 
    def array_from_file(file) 
      begin
        lines = Array.new
        File.open(file) { |file|
          file.readlines.each { |line|
            line = line.chomp 
            next if line.start_with?('#') or line.length < 2
            lines << line 
          }
        }
        lines
      rescue IOError => e
        puts "File error:  #{e}."
        exit
      end
    end  
    module_function :array_from_file

  end
end

