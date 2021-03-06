
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "resultt/version"

Gem::Specification.new do |spec|
  spec.name          = "resultt"
  spec.version       = Resultt::VERSION
  spec.authors       = ["Amr Bakry"]
  spec.email         = ["amrrbakry17@gmail.com"]

  spec.summary       = %q{A simple library to wrap execution result in smart success or error objects.}
  spec.license       = "MIT"
  spec.homepage       = "https://github.com/amrrbakry/resultt"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
