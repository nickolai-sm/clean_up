# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clean_up/version'

Gem::Specification.new do |spec|
  spec.name          = "clean_up"
  spec.version       = CleanUp::VERSION
  spec.authors       = ["Nickolai Smirnov"]
  spec.email         = ["sm-nickolai@gmail.com"]

  spec.summary       = %q{Files and Directories clean up tool.}
  spec.homepage      = "https://github.com/nickolai-sm/clean_up"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'mime-types', '~> 3.0'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10.3'
end
