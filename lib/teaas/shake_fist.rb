module Teaas
  class ShakeFist
    # Takes in an image, and adds shake_fist to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList]
    # @return [Magick::ImageList]
    def self.shake_fist(original_img, options={})
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/shake_fist.gif"))
    end

    # Takes in a path to an image, and adds shake_fist to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Spin.spin}
    #
    # @param path [String]
    # @return [Magick::ImageList]
    def self.shake_fist_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      shake_fist(img, options)
    end
  end
end
