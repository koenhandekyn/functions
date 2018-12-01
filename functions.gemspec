# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'functions/version'

Gem::Specification.new do |gem|
  gem.name          = "functions"
  gem.version       = Functions::VERSION
  gem.authors       = ["Koen Handekyn"]
  gem.email         = ["koen.handekyn@up-nxt.com"]
  gem.description   = %q{A prelude library that belongs to the book "functional programming in ruby".}
  gem.summary       = %q{functional programming in ruby}
  gem.homepage      = "https://github.com/koenhandekyn/functions"
  gem.license       = 'LGPL-3.0+'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
