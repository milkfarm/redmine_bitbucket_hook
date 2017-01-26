# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redmine_bitbucket_hook/version'

Gem::Specification.new do |spec|
  spec.name          = 'redmine_bitbucket_hook'
  spec.version       = RedmineBitbucketHook::VERSION
  spec.authors       = ['Jakob Skjerning', 'milkfarm productions']
  spec.email         = ['jakob@mentalized.net', 'stuff@milkfarmproductions.com']
  spec.summary       = 'Update your local Git repositories in Redmine when changes have been pushed to BitBucket.'
  spec.homepage      = 'http://milkfarmproductions.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
