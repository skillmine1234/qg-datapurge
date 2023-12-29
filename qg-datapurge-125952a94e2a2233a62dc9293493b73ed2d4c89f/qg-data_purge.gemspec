$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "qg/datapurge/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "qg-datapurge"
  s.version     = Qg::Datapurge::VERSION
  s.authors     = ["apjanvekar"]
  s.email       = ["apjanvekar@gmail.com"]
  s.homepage    = "http://apibanking.com/"
  s.summary     = "Datapurge Module."
  s.description = "Datapurge Module."
  s.license     = "MIT"

  s.metadata['allowed_push_host'] = 'https://oQrmd9sJbFtYSixtZKSR@gem.fury.io/quantiguous/'
  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 7.0.4"
  s.add_development_dependency "gemfury"

  s.add_development_dependency "sqlite3"
end
