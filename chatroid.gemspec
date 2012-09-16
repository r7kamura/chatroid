# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chatroid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["ryo-nakamura@cookpad.com"]
  gem.description   = "Chatroid is a gem for quickly creating chatterbot in Ruby"
  gem.summary       = "Chatterbot builder"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chatroid"
  gem.require_paths = ["lib"]
  gem.version       = Chatroid::VERSION

  gem.add_dependency "hashie"
  gem.add_development_dependency "rspec"
end
