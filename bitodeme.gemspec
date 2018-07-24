lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitodeme/version'

Gem::Specification.new do |spec|
  spec.name        = 'bitodeme'
  spec.version     = Bitodeme::VERSION
  spec.authors     = ['Bitodeme Integrations Team']
  spec.email       = ['integrations@bitodeme.com']
  spec.summary     = 'Bitodeme REST API Client'
  spec.description = 'Ruby client for Bitodeme REST API'
  spec.homepage    = 'https://github.com/bitodeme-integrations/bitodeme_rb'
  spec.license     = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 4.7'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'vcr', '~> 4.0'

  spec.add_dependency 'dotenv', '~> 2.2', '>= 2.2'
  spec.add_dependency 'faraday', '~> 0.15.2'
  spec.add_dependency 'faraday_middleware', '~> 0.12'
end
