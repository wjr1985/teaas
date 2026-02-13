# teaas
[![Build Status](https://travis-ci.org/wjr1985/teaas.svg?branch=master)](https://travis-ci.org/wjr1985/teaas) [![Gem Version](https://badge.fury.io/rb/teaas.svg)](https://badge.fury.io/rb/teaas)
## Total Emojis as a Service

Total Emojis as a Service (Teaas / TEAAS) is a lightweight library that wraps around [RMagick](https://github.com/rmagick/rmagick) and allows easy manipulation of emojis or emoji-like GIFs. Right now, it supports "Turbo"ing the emoji, making it spin, or making a marquee. This is a very early version, with more features and bug fixes to come in the future.

Version `1.0.0.bacon` and higher changes APIs from any prior versions, so make sure to check the documentation.

## Requirements

- Ruby 3.3 or higher
- `rmagick` ~> 6.1. `rmagick` requires ImageMagick to be installed where this is running. Some free hosts (Heroku a notable example) have this installed already, while others may not. Additionally, the Ruby you're using needs to be able to compile C extensions.

## Documentation
Docs are in [YARD](http://yardoc.org/) format. To build the HTML docs, just `gem install yard` then run `yard`. If you'd rather not use YARD, you can just read the documentation for the methods in the source files.

# Example
If you're looking for a full example, check out the Puma app [here](https://github.com/wjr1985/teaas_puma_example).

If you just want to know how to get a modified image from a file or a pre-provided `Magick::ImageList`, check below. The example uses `Teaas::Turbo` but you can replace it with any of the other classes in [lib/teaas](lib/teaas).

## From a file
```ruby
image_path = "image.gif"

result = Teaas::Turbo.turbo_from_file(image_path, false)
// result contains an array of image blobs
```

### From a `Magick::ImageList`

```ruby
image = Magick::ImageList.new

//populate image here

result = Teaas::Turbo.turbo(image, false)
// result contains an array of image blobs
```

# Questions / PRs, etc.
Feel free to open a GitHub issue or file a pull request if you have a question or would like something added.

# License
It's MIT. See the [LICENSE](https://github.com/wjr1985/teaas/blob/master/LICENSE) file.
