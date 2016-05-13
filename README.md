# teaas
[![Build Status](https://travis-ci.org/wjr1985/teaas.svg?branch=master)](https://travis-ci.org/wjr1985/teaas) [![Gem Version](https://badge.fury.io/rb/teaas.svg)](https://badge.fury.io/rb/teaas)
## Total Emojis as a Service

Total Emojis as a Service (Teaas / TEAAS) is a lightweight library that wraps around [RMagick](https://github.com/rmagick/rmagick) and allows easy manipulation of emojis or emoji-like GIFs. Right now, it supports "Turbo"ing the emoji, making it spin, or making a marquee. This is a very early version, with more features and bug fixes to come in the future.

Version `1.0.0.bacon` and higher changes APIs from any prior versions, so make sure to check the documentation.

## Requirements

- Ruby 1.9.2 or higher
- `rmagick` ~> 2.15.4. `rmagick` requires ImageMagick to be installed where this is running. Some free hosts (Heroku a notable example) have this installed already, while others may not. Additionally, the Ruby you're using needs to be able to compile C extensions.

### "Turbo"ing / Turboize

"Turbo"ing or Turboize involves changing the GIF animation delay to 1 second, and adjusting the ticks per second to make the emoji speed up or slow down.

### Spin

Spinning an image just takes the image that is input and makes it spin clockwise or counterclockwise. Additionally, it can now spin animated GIFs, as long as the option is selected. Otherwise, will spin a single frame of the GIF.

**NOTE**: Spinning only works best on images that are square (32x32 for example). Images that are not square may return unexpected results.

**NOTE**: Spinning removes any transparency from the image.

### Marquee

Making an image a marquee involves taking a static image, and making intermediate images so that when the emojis are next to each other, they look like they're flowing together (like a marquee). It's best to try it out and see the results.

**NOTE**: Marquee removes any transparency from the image.

**NOTE**: Marquee supports aniamted GIFs, however depending on the type of GIF, it may not work properly.

### Blood

This overlays a blood animation over the image. Only works for static images, or a single frame of the GIF.

**NOTE**: Blood removes any transparency from the image.

### Fire

This overlays a fire animation over the image. Only works for static images, or a single frame of the GIF.

**NOTE**: Fire removes any transparency from the image.

## Documentation
Docs are in [YARD](http://yardoc.org/) format. To build the HTML docs, just `gem install yard` then run `yard`. If you'd rather not use YARD, you can just read the documentation for the methods in the source files.

# Example
If you're looking for a full example, I built a hacky, yet functional, example Heroku app [here](https://github.com/wjr1985/teaas_heroku_example).

If you're just interested in code snippets, check these out:

## Turbo
### From a file
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

## Spin
### From a file
```ruby
image_path = "image.gif"

spin_result = Teaas::Spin.spin_from_file(image_path)
final_result = Teaas::Turbo.turbo(spin_result, false)
// final_result contains an array of image blobs
```

### From a `Magick::ImageList`
```ruby
image = Magick::ImageList.new

//populate image here

spin_result = Teaas::Spin.spin(image)
final_result = Teaas::Turbo.turbo(spin_result, false)
// final_result contains an array of image blobs
```

## Marquee
### From a file
```ruby
image_path = "image.gif"

marquee_result = Teaas::Marquee.marquee_from_file(image_path)
final_result = Teaas::Turbo.turbo(marquee_result, false)
// final_result contains an array of image blobs
```

### From a `Magick::ImageList`
```ruby
image = Magick::Image.read("file.png")

marquee_result = Teaas::Marquee.marquee(image)
final_result = Teaas::Turbo.turbo(marquee_result, false)
// final_result contains an array of image blobs
```

## Bloodify
### From a file
```ruby
image_path = "image.gif"

bloodify_result = Teaas::Blood.blood_from_file(image_path)
final_result = Teaas::Turbo.turbo(blood_result, false)
// final_result contains an array of image blobs
```

### From a `Magick::ImageList`
```ruby
image = Magick::Image.read("file.png")

blood_result = Teaas::Blood.blood(image)
final_result = Teaas::Turbo.turbo(marquee_result, false)
// final_result contains an array of image blobs
```

## Fireify
### From a file
```ruby
image_path = "image.gif"

fireify_result = Teaas::Fire.fire_from_file(image_path)
final_result = Teaas::Turbo.turbo(fire_result, false)
// final_result contains an array of image blobs
```

### From a `Magick::ImageList`
```ruby
image = Magick::Image.read("file.png")

fire_result = Teaas::Fire.fire(image)
final_result = Teaas::Turbo.turbo(marquee_result, false)
// final_result contains an array of image blobs
```

# Questions / PRs, etc.
Feel free to open a GitHub issue or file a pull request if you have a question or would like something added.

# License
It's MIT. See the [LICENSE](https://github.com/wjr1985/teaas/blob/master/LICENSE) file.
