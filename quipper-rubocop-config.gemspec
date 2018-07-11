
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
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pronto", "0.9.5"
  spec.add_dependency "pronto-rubocop", "~> 0.9.0"
  spec.add_dependency "rubocop", "~> 0.58.1"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
