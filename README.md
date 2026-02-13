# teaas
[![Tests](https://github.com/wjr1985/teaas/actions/workflows/tests.yml/badge.svg)](https://github.com/wjr1985/teaas/actions/workflows/tests.yml) [![Gem Version](https://badge.fury.io/rb/teaas.svg)](https://badge.fury.io/rb/teaas)
## Total Emojis as a Service

Total Emojis as a Service (Teaas / TEAAS) is a Ruby library that wraps around [RMagick](https://github.com/rmagick/rmagick) and allows easy manipulation of emojis or emoji-like GIFs. Every effect works on both static images and animated GIFs, and each class provides a `_from_file` convenience method so you can pass a path instead of a `Magick::ImageList`.

## Effects

### Transforms
| Class | Description |
|---|---|
| `Spin` | Rotates the image to create a spinning animation. Supports custom rotation count and counterclockwise mode. |
| `Intensify` | Composites a slightly smaller copy of the image at alternating corners for a shaking/intensified effect (7 frames). |
| `Pulse` | Rotates and resize-fills each frame to create a pulsing animation (8 frames). |
| `Parrotify` | Bobs the image through 10 predefined offset positions, party-parrot style. |
| `Marquee` | Rolls the image horizontally or vertically to create a scrolling marquee. Supports animated input and a crop option for tall images. |
| `Mirror` | Flips the image horizontally. Returns a single image for static input or a mirrored ImageList for animated input. |
| `Reverse` | Reverses the frame order of an animated GIF. |
| `Dealwithit` | Animates sunglasses descending onto the image (15 frames, with a pause on the last frame). |

### Overlays
| Class | Description |
|---|---|
| `Fire` | Overlays animated flames. |
| `Blood` | Overlays animated dripping blood. |
| `Heart` | Overlays animated hearts. |
| `Tears` | Overlays animated tears. |
| `Fireworks` | Overlays animated fireworks. |
| `ShakeFist` | Overlays an animated shaking fist. |
| `Wait` | Overlays an animated loading/wait indicator. |
| `No` | Overlays a static "no" symbol (works on animated input). |
| `Think` | Overlays a static thinking bubble (works on animated input). |
| `Magrittify` | Overlays a green apple, Magritte-style (works on animated input). |
| `Got` | Combines fire and blood overlays for a Game of Thrones effect. |

### Utilities
| Class | Description |
|---|---|
| `Turboize` | Adjusts animation speed. Takes an array of speeds and returns an array of GIF blobs, one per speed. Optionally resizes. |
| `Resize` | Resizes an image or animated GIF to the specified dimensions. |
| `Overlayer` | Low-level overlay engine used by the overlay effects. Handles animated-on-static, static-on-animated, and animated-on-animated compositing. |

## Requirements

- Ruby 3.3 or higher
- `rmagick` ~> 6.1. `rmagick` requires ImageMagick to be installed. Additionally, the Ruby you're using needs to be able to compile C extensions.

## Documentation
Docs are in [YARD](http://yardoc.org/) format. To build the HTML docs, just `gem install yard` then run `yard`. If you'd rather not use YARD, you can just read the documentation for the methods in the source files.

# Example
If you're looking for a full example, check out the Puma app [here](https://github.com/wjr1985/teaas_puma_example).

If you just want to know how to get a modified image from a file or a pre-provided `Magick::ImageList`, check below. The example uses `Teaas::Turboize` but you can replace it with any of the other classes in [lib/teaas](lib/teaas).

## From a file
```ruby
image_path = "image.gif"

result = Teaas::Turboize.turbo_from_file(image_path, "")
# result contains an array of image blobs
```

### From a `Magick::ImageList`

```ruby
image = Magick::ImageList.new

# populate image here

result = Teaas::Turboize.turbo(image, "")
# result contains an array of image blobs
```

# Questions / PRs, etc.
Feel free to open a GitHub issue or file a pull request if you have a question or would like something added.

# License
It's MIT. See the [LICENSE](https://github.com/wjr1985/teaas/blob/master/LICENSE) file.
