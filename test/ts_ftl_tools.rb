# This is the cumulative test suite for the entire
# FTL Tools program. Test Cases will be 
# written for each component program and named
# "tc_<Program>.rb

$LOAD_PATH << File.expand_path("../../lib", __FILE__)
$LOAD_PATH << File.expand_path("../../test", __FILE__)

require "test/unit"

Dir.glob("test/tc_*").each do |file|
  require File.basename(file)
end
