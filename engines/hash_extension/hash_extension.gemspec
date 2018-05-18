$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hash_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hash_extension"
  s.version     = HashExtension::VERSION
  s.authors     = ["James Naadjie"]
  s.email       = ["james.naadjie@gmail.com"]
  s.homepage    = "http://www.zaafigroup.com"
  s.summary     = "Hash extensions"
  s.description = "Description of HashExtension."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
