module Teaas
  class Heart
    # Takes in an image, and adds hearts to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds.
    #
    # @param original_img [Magick::ImageList] The image to be engufled in flames
    # @return [Magick::ImageList] The image, now on fire
    def self.heart(original_img, options={})
      Overlayer.overlay(original_img, Magick::ImageList.new(Teaas.root + "/img/heart.gif"))
    end

    # Takes in a path to an image, and adds hearts to it. Best when used with {Teaas::Turboize.turbo} to generate multiple rotation speeds. This is a wrapper around {Teaas::Heart.heart}
    #
    # @param path [String] Path to the image to be engulfed in flames
    # @return [Magick::ImageList] The image, now on fire
    def self.heart_from_file(path, options={})
      img = Magick::ImageList.new

      # Grab the first element in array to prevent strange things when an
      # animated image is submitted
      img.read(path)[0]

      heart(img)
    end
  end
end
