
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "states/dsl/version"

Gem::Specification.new do |spec|
  spec.name          = "states-dsl"
  spec.version       = States::Dsl::VERSION
  spec.authors       = ["Calvin Yu"]
  spec.email         = ["calvin@rylabs.io"]

  spec.summary       = %q{Create AWS Step Function JSON from a DSL}
  spec.description   = %q{Create AWS Step Function JSON from a DSL}
  spec.homepage      = "http://github.com/rylabs/states-dsl"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["states-dsl"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
