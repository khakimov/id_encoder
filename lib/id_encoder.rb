# Short URL Generator
# ===================

# Ruby implementation for generating Tiny URL- and bit.ly-like URLs.

# A bit-shuffling approach is used to avoid generating consecutive, predictable 
# URLs. However, the algorithm is deterministic and will guarantee that no 
# collisions will occur.

# The URL alphabet is fully customizable and may contain any number of 
# characters.  By default, digits and lower-case letters are used, with 
# some removed to avoid confusion between characters like o, O and 0.  The 
# default alphabet is shuffled and has a prime number of characters to further 
# improve the results of the algorithm.

# The block size specifies how many bits will be shuffled.  The lower BLOCK_SIZE 
# bits are reversed.  Any bits higher than BLOCK_SIZE will remain as is.
# BLOCK_SIZE of 0 will leave all bits unaffected and the algorithm will simply 
# be converting your integer to a different base.

# The intended use is that incrementing, consecutive integers will be used as 
# keys to generate the short URLs.  For example, when creating a new URL, the 
# unique integer ID assigned by a database could be used to generate the URL 
# by using this module.  Or a simple counter may be used.  As long as the same 
# integer is not used twice, the same short URL will not be generated twice.

# The module supports both encoding and decoding of URLs. The min_length 
# parameter allows you to pad the URL if you want it to be a specific length.

# Sample Usage:
#
# gem install id_encoder
#
# >> require 'id_encoder'
# => true
# >> IdEncoder::UrlEncoder.encode_url(10)
# => "csqsc"
# >> IdEncoder::UrlEncoder.decode_url('csqsc')
# => 10
# 
# Use the functions in the top-level of the module to use the default encoder. 
# Otherwise, you may create your own UrlEncoder object and use its encode_url 
# and decode_url methods.

# Author of Python version: Michael Fogleman
# Link: http://code.activestate.com/recipes/576918/
# License: MIT

# Author of Ruby version: Ruslan Khakimov
# Link: http://github.com/khakimov/id_encoder
# License: MIT

require "id_encoder/version"

DEFAULT_ALPHABET = 'mn6j2c4rv8bpygw95z7hsdaetxuk3fq'
DEFAULT_BLOCK_SIZE = 24
MIN_LENGTH = 4

module IdEncoder
	class UrlEncoder

		@alphabet = DEFAULT_ALPHABET
		@block_size = DEFAULT_BLOCK_SIZE
		@mask = (1 << @block_size) - 1 # left-shift
		@mapping = (0..(@block_size-1)).to_a.reverse!

		def self.encode_url(n, min_length=MIN_LENGTH)
			enbase(encode(n), min_length)
		end

		def self.decode_url(n)
			decode(debase(n))
		end

		def self.encode(n)
			(n & ~@mask) | _encode(n & @mask)
		end

		def self.decode(n)
			(n & ~@mask) | _decode(n & @mask)
		end

		def self._encode(n)
			result = 0
			@mapping.each_with_index { |item, index|
				if n & (1 << index) != 0
					result = result | (1 << item)
				end
			}
			result
		end

		def self._decode(n)
			result = 0
			@mapping.each_with_index { |item, index|
				if n & (1 << item) != 0
					result = result | (1 << index)
				end
			}
		 	result
		end

		def self.enbase(x, min_length=MIN_LENGTH)
			_enbase(x)
		end

		def self._enbase(x)
			n = @alphabet.size
			if x < n
				return @alphabet[x]
			end
			_enbase(x/n) + @alphabet[x % n]
		end

		def self.debase(x)
			n = @alphabet.size
			result = 0
			a = x.split('').reverse
			a.each_with_index {|item, i|
				result += @alphabet.index(item) * (n ** i)
			}
			result
		end
	end
end