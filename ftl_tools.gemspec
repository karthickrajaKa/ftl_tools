
Gem::Specification.new do |s|
  s.name          = "ftl_tools".freeze
  s.version       = "0.0.5-alpha"
  s.authors       = ["Leam Hall"]
  s.email         = "freetradeleague@gmail.com"
  s.homepage      = "https://github.com/makhidkarun/ftl_tools"
  Dir.glob("bin/*").each {|f|
    s.executables   << File.basename(f)
  }
  s.licenses      = ["GPL-3.0"]
  s.platform      = Gem::Platform::RUBY
  s.summary       = "Ruby Tools for 2d6 OGL Games."
  s.description   = "People, planets, names, dice, etc."
  s.files         = Dir.glob("{bin,data,docs,lib,views}/**/*")
  s.require_paths = ["lib"]
  s.add_runtime_dependency 'sqlite3', '~> 1'
end
