# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hnews/version'

Gem::Specification.new do |spec|
  spec.name          = "hnews-suggest"
  spec.version       = HNews::VERSION
  spec.authors       = ["Greg Chapple"]
  spec.email         = ["gregchapple1@gmail.com"]
  spec.summary       = %q{Automatically suggest articles from Hacker News}
  spec.description   = %q{Suggest articles from Hacker News. Suggestions will get better over time as the gem learns what you like!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "activesupport", "4.1.1"


  spec.add_dependency "sequel"
  spec.add_dependency "sqlite3"
  spec.add_dependency "nokogiri"
  spec.add_dependency "thor"
  spec.add_dependency "launchy"
end
