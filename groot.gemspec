# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem"s version:
require "groot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "groot"
  spec.version     = Groot::VERSION
  spec.authors     = ["Alisson Bruno"]
  spec.email       = ["alissonbruno.sa@gmail.com"]

  spec.summary     = "Simple token authentication and authorization"
  spec.description = "Simple token authentication and authorization solution for Rails with JWT."
  spec.homepage    = "https://github.com/alissonbrunosa/groot"
  spec.license     = "MIT"

  # spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.add_dependency "rails", "~> 5.0", ">= 5.0.0"
  spec.add_dependency "jwt", "~> 1.5", ">= 1.5.6"
  spec.add_dependency "bcrypt", "~> 3.1", ">= 3.1.7"

  spec.add_development_dependency "sqlite3", "~> 1.3"
end
