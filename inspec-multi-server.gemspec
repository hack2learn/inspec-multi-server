# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inspec-multi-server/version'

Gem::Specification.new do |spec|
  spec.name          = "inspec-multi-server"
  spec.version       = InSpecMultiServer::VERSION
  spec.authors       = ["Kaddu Patrick"]
  spec.email         = ["patrick.kaddu@novartis.com"]
  spec.summary       = %q{command line tool to run chef inspec tests on multiple servers.}
  spec.description   = %q{command line tool to run chef inspec tests on multiple servers.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "inspec", "~> 0.9.8"
  spec.add_development_dependency('aruba', '~> 0.5')
  spec.add_runtime_dependency('gli','2.12.0')
  spec.add_runtime_dependency('net-ssh', '~> 2.9')
  spec.add_runtime_dependency('colorize', '~> 0.7')
  spec.add_runtime_dependency('highline')
  spec.add_runtime_dependency('parseconfig')
end
