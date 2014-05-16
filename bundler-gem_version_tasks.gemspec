# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundler/gem_version_tasks/version'

Gem::Specification.new do |spec|
  spec.name          = "bundler-gem_version_tasks"
  spec.version       = Bundler::GemVersionTasks::VERSION
  spec.authors       = ["yann ARMAND"]
  spec.email         = ["yann@harakys.com"]
  spec.summary       = %q{Helper rake tasks to update gem version.}
  spec.description   = %q{To complete standards bundler rake tasks, 
  this gem add a series of tasks to display, bump and write the gem version.
    }
  spec.homepage      = "https://github.com/yarmand/bundler-gem_version_tasks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
