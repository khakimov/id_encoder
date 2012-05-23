# -*- encoding: utf-8 -*-
require File.expand_path('../lib/id_encoder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ruslan Khakimov"]
  gem.email         = ["ruslan@khakimov.com"]
  gem.description   = %q{A bit-shuffling approach is used to avoid generating 
    consecutive, predictable URLs. However, the algorithm is deterministic and 
    will guarantee that no collisions will occur.
    
    The gem supports both encoding and decoding of URLs. The min_length parameter 
    allows you to pad the URL if you want it to be a specific length.
  }
  gem.summary       = %q{Ruby implementation for generating Tiny URL- and bit.ly-like URLs.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "id_encoder"
  gem.require_paths = ["lib"]
  gem.version       = IdEncoder::VERSION
end
