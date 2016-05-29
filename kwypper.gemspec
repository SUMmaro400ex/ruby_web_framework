# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kwypper/version'

Gem::Specification.new do |spec|
  spec.name          = "kwypper"
  spec.version       = Kwypper::VERSION
  spec.authors       = ["Diego Salazar", "Sean Sellek"]
  spec.email         = ["diego@greyrobot.com", "sean@wyncode.co"]

  spec.summary       = %q{Based off of [Kwipper](github.com/diegosalazar/kwipper_challenge), Kwypper is a simple web framework designed for Wyncode's Wynmasters program.}
  spec.description   = %q{Based off of [Kwipper](github.com/diegosalazar/kwipper_challenge), Kwypper is a simple web framework designed for Wyncode's Wynmasters program.}
  spec.homepage      = "httpsa://github.com/wyncode/kwypper"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'
  spec.add_dependency 'mime-types'
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
