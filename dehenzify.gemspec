lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dehenzify/version'

Gem::Specification.new do |spec|
  spec.name          = 'dehenzify'
  spec.version       = Dehenzify::VERSION
  spec.authors       = ['Reinier de Lange']
  spec.email         = ['rjdelange@icloud.com']

  spec.summary       = 'Dehenzify'
  spec.description   = 'Dehenzify'
  spec.homepage      = "https://github.com/moiristo/dehenzify"
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'parser'
  spec.add_runtime_dependency 'rubocop'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
