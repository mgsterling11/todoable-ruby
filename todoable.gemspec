
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "todoable/version"

Gem::Specification.new do |spec|
  spec.name          = "todoable"
  spec.version       = Todoable::VERSION
  spec.authors       = ["Michael Nwani"]
  spec.email         = ["k.mnwani@gmail.com"]

  spec.summary       = %q{A Teachable "Todoable" API Ruby wrapper}
  spec.description   = %q{Use this gem to interface with Todoable's 9 HTTP endpoints (including authentication)}
  spec.homepage      = "https://github.com/michaelnwani/todoable-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "cucumber"
  spec.add_dependency "aruba"
  spec.add_dependency "thor"
end
