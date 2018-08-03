# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "quipper/rubocop/config/version"

Gem::Specification.new do |spec|
  spec.name          = "quipper-rubocop-config"
  spec.version       = Quipper::Rubocop::Config::VERSION
  spec.authors       = ["Drew Terry"]
  spec.email         = ["drewpterry@yahoo.com"]

  spec.summary       = "Quipper's rubocop config"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "0.58.1" # Rubocop doesn't follow semantic versioning and is relatively unstable
  spec.add_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
