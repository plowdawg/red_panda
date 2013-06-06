$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "red_panda/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "red_panda"
  s.version     = RedPanda::VERSION
  s.authors     = ["Travis Pessetto"]
  s.email       = ["travis.pessetto@es3inc.com"]
  s.homepage    = "http://www.es3inc.com"
  s.summary     = "A library for determining MACRS Straight Line Depreciation."
  s.description = "Library to determine MACRS Straight Line Depreciation of assets.."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
