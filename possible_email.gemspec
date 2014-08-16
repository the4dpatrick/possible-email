# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'possible_email/version'

Gem::Specification.new do |spec|
  spec.name          = "possible_email"
  spec.version       = PossibleEmail::VERSION
  spec.authors       = ["Patrick Perey"]
  spec.email         = ["the4dpatrick@yahoo.com"]
  spec.summary       = %q{Find anyone's email using their first name, last name, and domain.}
  spec.description   = %q{Find anyone's email using their first name, last name, and domain.}
  spec.homepage      = "https://github.com/the4dpatrick/possible-email"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httpi', '~> 2.2', '>= 2.2.5'
  spec.add_dependency 'thor', '~> 0.19', '>= 0.19.1'
  spec.add_dependency 'rubyntlm', '~> 0.3.4'

  spec.add_development_dependency 'bundler', "~> 1.5"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'growl'
  spec.add_development_dependency 'coveralls'

end
