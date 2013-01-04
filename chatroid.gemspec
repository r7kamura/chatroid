# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chatroid/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["r7kamura@gmail.com"]
  gem.description   = "Chatroid is a gem for quickly creating chatterbot in Ruby"
  gem.summary       = "Chatterbot builder"
  gem.homepage      = "https://github.com/r7kamura/chatroid"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chatroid"
  gem.require_paths = ["lib"]
  gem.version       = Chatroid::VERSION
  gem.license       = 'MIT'

  gem.add_dependency "twitter-stream"
  gem.add_dependency "twitter_oauth"
  gem.add_dependency "xmpp4r"
  gem.add_dependency "avalon"
  gem.add_dependency "zircon"
  gem.add_dependency "tinder"
  gem.add_development_dependency "rspec"
end
