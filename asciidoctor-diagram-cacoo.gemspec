# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asciidoctor/diagram/cacoo/version'

Gem::Specification.new do |spec|
  spec.name          = "asciidoctor-diagram-cacoo"
  spec.version       = Asciidoctor::Diagram::Cacoo::VERSION
  spec.authors       = ["Hiroaki Nakamura"]
  spec.email         = ["hnakamur@gmail.com"]
  spec.summary       = %q{a ruby gem for asciidoctor-diagram to use Cacoo diagrams}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/hnakamur/asciidoctor-diagram-cacoo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
