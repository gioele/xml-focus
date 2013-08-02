# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'xml/focus/version'

Gem::Specification.new do |spec|
	spec.name          = "xml-focus"
	spec.version       = XML::Focus::VERSION
	spec.authors       = ['Gioele Barabucci']
	spec.email         = ['gioele@svario.it']
	spec.summary       = "Extract XML subtrees"
	spec.description   = "Extract subtrees from XML trees, making sure " +
	                     "that the overall structure is preserved."
	spec.homepage      = 'http://github.com/gioele/xml-focus'
	spec.license       = 'CC0'

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ['lib']

	spec.add_dependency 'nokogiri'

	spec.add_development_dependency 'bundler', '~> 1.3'
	spec.add_development_dependency 'rake'
	spec.add_development_dependency 'rspec'
end
