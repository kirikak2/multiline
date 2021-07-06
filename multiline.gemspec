require_relative 'lib/multiline/version'

Gem::Specification.new do |spec|
  spec.name          = "multiline"
  spec.version       = Multiline::VERSION
  spec.authors       = ["Toshio Maki"]
  spec.email         = ["kirika.k2@gmail.com"]

  spec.summary       = %q{Malipulate multiple lines as one line.}
  spec.description   = %q{Malipulate multiple lines as one line.}
  spec.homepage      = "https://github.com/kirikak2/multiline"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "unicode-display_width"
  spec.add_dependency "unicode-emoji"
end
