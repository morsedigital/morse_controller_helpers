# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'morse_controller_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "morse_controller_helpers"
  spec.version       = MorseControllerHelpers::VERSION
  spec.authors       = ["Terry S"]
  spec.email         = ["itsterry@gmail.com"]

  spec.summary       = %q{Morse Controller Helpers}
  spec.description   = %q{Morse Controller Helpers}
  spec.homepage      = "https://github.com/morsedigital/morse_controller_helpers"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rubocop"
  spec.add_dependency 'activesupport'
  spec.add_dependency 'rails'
end
