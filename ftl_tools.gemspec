
Gem::Specification.new do |s|
  s.name          = "ftl_tools".freeze
  s.version       = "0.0.2-alpha"
  s.authors       = ["Leam Hall"]
  s.email         = "leamhall@gmail.com"
  s.homepage      = "https://github.com/makhidkarun/ftl_tools"
  Dir.glob("bin/*").each {|f|
    s.executables   << File.basename(f)
  }
  s.licenses      = ["GPL-3.0"]
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Ruby Tools for 2d6 OGL Games."
  s.description   = "Planets, names, dice, etc."
  s.files         = Dir.glob("{bin,data,docs,lib}/**/*")
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'mongo', '~> 2.0'
end
