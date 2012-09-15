# -*- encoding: utf-8 -*-
require File.expand_path('../lib/yunotti/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryo NAKAMURA"]
  gem.email         = ["ryo-nakamura@cookpad.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "yunotti"
  gem.require_paths = ["lib"]
  gem.version       = Yunotti::VERSION

  gem.add_dependency "hashie"
  gem.add_development_dependency "rspec"
end
