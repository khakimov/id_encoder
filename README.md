# IdEncoder

Ruby implementation for generating Tiny URL- and bit.ly-like URLs.

A bit-shuffling approach is used to avoid generating consecutive, predictable 
URLs. However, the algorithm is deterministic and will guarantee that no 
collisions will occur.

The URL alphabet is fully customizable and may contain any number of 
characters.  By default, digits and lower-case letters are used, with 
some removed to avoid confusion between characters like o, O and 0.  The 
default alphabet is shuffled and has a prime number of characters to further 
improve the results of the algorithm.

The block size specifies how many bits will be shuffled.  The lower BLOCK_SIZE 
bits are reversed.  Any bits higher than BLOCK_SIZE will remain as is.
BLOCK_SIZE of 0 will leave all bits unaffected and the algorithm will simply 
be converting your integer to a different base.

The intended use is that incrementing, consecutive integers will be used as 
keys to generate the short URLs.  For example, when creating a new URL, the 
unique integer ID assigned by a database could be used to generate the URL 
by using this module.  Or a simple counter may be used.  As long as the same 
integer is not used twice, the same short URL will not be generated twice.

The module supports both encoding and decoding of URLs. The min_length 
parameter allows you to pad the URL if you want it to be a specific length.

## Installation

Add this line to your application's Gemfile:

    gem 'id_encoder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install id_encoder

## Usage

	>> require 'id_encoder'
	=> true
	>> IdEncoder::UrlEncoder.encode_url(10)
	=> "csqsc"
	>> IdEncoder::UrlEncoder.decode_url('csqsc')
	=> 10

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
