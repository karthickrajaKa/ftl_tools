#!/usr/bin/env ruby
$VERBOSE = true

# crewgen.rb
lib_dir = File.expand_path("../lib", __dir__)
exec("rackup -I #{lib_dir}  -r ftl_tools -s thin -p 4567 #{lib_dir}/crewgen_config.ru")
