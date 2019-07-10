#!/usr/bin/env ruby
$VERBOSE = true

# bin/crewgen.rb
# Runs rackup to start the crewgen app.

run_dir = Dir.pwd
lib_dir = run_dir + '/lib'
bin_dir = run_dir + '/bin/'
system("rackup -I #{lib_dir}  -r ftl_tools -s thin -p 4567 #{bin_dir}/crewgen_config.ru")
