# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/logger/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-logger"
  spec.version       = RSpec::Logger::VERSION
  spec.authors       = ["Anton Shemerey"]
  spec.email         = ["shemerey@gmail.com"]
  spec.summary       = %q{More readable log output}
  spec.description   = %q{simple wrapper around rspec example to make log output more useful}
  spec.homepage      = "http://github.com/shemerey/rspec-logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
